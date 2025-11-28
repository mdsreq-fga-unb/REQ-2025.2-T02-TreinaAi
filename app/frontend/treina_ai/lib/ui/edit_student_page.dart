import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'components.dart';
import '../models/client.dart';
import '../data/clients_database.dart';
import '../repositories/image_repository.dart';

// ==================== CUSTOM INPUT FORMATTERS ====================

/// Formata altura para X.XX (máx 1 dígito antes do ponto, 2 depois)
class HeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    
    // Substitui vírgula por ponto
    text = text.replaceAll(',', '.');
    
    // Remove tudo que não é número ou ponto
    text = text.replaceAll(RegExp(r'[^0-9.]'), '');
    
    if (text.isEmpty) {
      return newValue.copyWith(text: text);
    }
    
    // Se tem ponto, formata para X.XX
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length > 2) {
        // Mais de um ponto, remove os extras
        text = '${parts[0]}.${parts[1]}';
      }
      
      // Limita antes do ponto a 1 dígito
      if (parts[0].length > 1) {
        parts[0] = parts[0].substring(0, 1);
      }
      
      // Limita depois do ponto a 2 dígitos
      if (parts[1].length > 2) {
        parts[1] = parts[1].substring(0, 2);
      }
      
      text = '${parts[0]}.${parts[1]}';
    } else {
      // Sem ponto, apenas dígitos
      if (text.length > 1) {
        // Insere ponto automaticamente entre o primeiro e segundo dígito
        text = '${text[0]}.${text.substring(1)}';
      }
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}

/// Formata peso para XXX.XX (máx 3 dígitos antes do ponto, 2 depois)
class WeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    
    // Substitui vírgula por ponto
    text = text.replaceAll(',', '.');
    
    // Remove tudo que não é número ou ponto
    text = text.replaceAll(RegExp(r'[^0-9.]'), '');
    
    if (text.isEmpty) {
      return newValue.copyWith(text: text);
    }
    
    // Se tem ponto, formata para XXX.XX
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length > 2) {
        // Mais de um ponto, remove os extras
        text = '${parts[0]}.${parts[1]}';
      }
      
      // Limita antes do ponto a 3 dígitos
      if (parts[0].length > 3) {
        parts[0] = parts[0].substring(0, 3);
      }
      
      // Limita depois do ponto a 2 dígitos
      if (parts[1].length > 2) {
        parts[1] = parts[1].substring(0, 2);
      }
      
      text = '${parts[0]}.${parts[1]}';
    } else {
      // Sem ponto, apenas dígitos - máx 3
      if (text.length > 3) {
        text = text.substring(0, 3);
      }
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}

/// Formata idade para máx 3 dígitos
class AgeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    
    // Apenas dígitos
    text = text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Máx 3 dígitos
    if (text.length > 3) {
      text = text.substring(0, 3);
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}

/// Formata decimal genérico (vírgula como ponto)
class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Se o usuário digitou vírgula, substitui por ponto
    String text = newValue.text.replaceAll(',', '.');
    
    // Permite apenas dígitos e um ponto
    if (text.isEmpty) {
      return newValue.copyWith(text: text);
    }
    
    // Verifica se há mais de um ponto
    final dotCount = text.split('.').length - 1;
    if (dotCount > 1) {
      // Mantém o texto anterior
      return oldValue;
    }
    
    return newValue.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
  }
}

class EditStudentPage extends StatefulWidget {
  final Client client;
  final VoidCallback onSaveSuccess;

  const EditStudentPage({
    super.key,
    required this.client,
    required this.onSaveSuccess,
  });

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late String selectedGender;
  bool _isSaving = false;
  late String? _currentPhotoPath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.client.name);
    descriptionController = TextEditingController(text: widget.client.desc ?? '');
    ageController = TextEditingController(text: widget.client.age?.toString() ?? '');
    heightController = TextEditingController(text: widget.client.height?.toString() ?? '');
    weightController = TextEditingController(text: widget.client.weight?.toString() ?? '');
    selectedGender = widget.client.gender ?? 'Masculino';
    _currentPhotoPath = widget.client.photoPath;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  /// Abre um diálogo para escolher entre câmera ou galeria
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecionar Imagem'),
          content: const Text('De onde você quer selecionar a imagem?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
              child: const Text('Câmera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
              child: const Text('Galeria'),
            ),
          ],
        );
      },
    );
  }

  /// Seleciona imagem da câmera
  Future<void> _pickImageFromCamera() async {
    try {
      final imageFile = await ImageRepository.instance.pickImageFromCamera();

      if (imageFile == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nenhuma imagem foi capturada')),
          );
        }
        return;
      }

      // Salva a imagem localmente
      final savedPath = await ImageRepository.instance
          .saveImageLocally(imageFile, widget.client.codClient!);

      if (savedPath != null) {
        setState(() {
          _currentPhotoPath = savedPath;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto capturada com sucesso!')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar a foto')),
          );
        }
      }
    } catch (e) {
      debugPrint('Erro ao capturar imagem: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  /// Seleciona imagem da galeria
  Future<void> _pickImageFromGallery() async {
    try {
      final imageFile = await ImageRepository.instance.pickImageFromGallery();

      if (imageFile == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nenhuma imagem foi selecionada')),
          );
        }
        return;
      }

      // Salva a imagem localmente
      final savedPath = await ImageRepository.instance
          .saveImageLocally(imageFile, widget.client.codClient!);

      if (savedPath != null) {
        setState(() {
          _currentPhotoPath = savedPath;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto selecionada com sucesso!')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar a foto')),
          );
        }
      }
    } catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  /// Remove a foto atual
  Future<void> _removePhoto() async {
    if (_currentPhotoPath == null || _currentPhotoPath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma foto para remover')),
      );
      return;
    }

    // Mostra diálogo de confirmação
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remover Foto'),
          content: const Text('Tem certeza que deseja remover a foto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remover', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldRemove == true) {
      try {
        final deleted =
            await ImageRepository.instance.deleteImageLocally(_currentPhotoPath!);

        if (deleted) {
          setState(() {
            _currentPhotoPath = null;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Foto removida com sucesso!')),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro ao remover a foto')),
            );
          }
        }
      } catch (e) {
        debugPrint('Erro ao remover foto: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: $e')),
          );
        }
      }
    }
  }

  Future<void> _saveChanges() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome não pode ser vazio')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final updatedClient = Client(
        codClient: widget.client.codClient,
        name: nameController.text.trim(),
        desc: descriptionController.text.trim().isNotEmpty
            ? descriptionController.text.trim()
            : null,
        photoPath: _currentPhotoPath,
        age: ageController.text.isNotEmpty
            ? int.tryParse(ageController.text)
            : null,
        height: heightController.text.isNotEmpty
            ? double.tryParse(heightController.text)
            : null,
        weight: weightController.text.isNotEmpty
            ? double.tryParse(weightController.text)
            : null,
        gender: selectedGender,
        codUser: widget.client.codUser,
      );

      debugPrint('========== SALVANDO CLIENTE ==========');
      debugPrint('Client ID: ${updatedClient.codClient}');
      debugPrint('Nome: ${updatedClient.name}');
      debugPrint('Descrição: ${updatedClient.desc}');
      debugPrint('Idade: ${updatedClient.age}');
      debugPrint('Altura: ${updatedClient.height}');
      debugPrint('Peso: ${updatedClient.weight}');
      debugPrint('Gênero: ${updatedClient.gender}');
      debugPrint('Foto: ${updatedClient.photoPath}');
      debugPrint('=====================================');

      await ClientsDatabase.instance.updateClient(updatedClient);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aluno atualizado com sucesso!')),
        );

        widget.onSaveSuccess();
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Erro ao salvar alterações: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _deleteStudent() async {
    // Mostra dialog de confirmação
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Aluno'),
          content: Text(
            'Tem certeza que deseja excluir o aluno "${widget.client.name}"? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    // Se o usuário confirmou
    if (shouldDelete == true) {
      setState(() {
        _isSaving = true;
      });

      try {
        await ClientsDatabase.instance.deleteClient(widget.client.codClient!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aluno excluído com sucesso!')),
          );

          // Volta com true para indicar que houve mudança
          Navigator.pop(context, true);
          // Volta novamente para sair do EditStudentPage
          Navigator.pop(context, true);
        }
      } catch (e) {
        debugPrint('Erro ao deletar aluno: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao deletar: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==================== HEADER COM BACK BUTTON ====================
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // ==================== FOTO DO ESTUDANTE ====================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: _currentPhotoPath != null
                          ? DecorationImage(
                              image: FileImage(
                                  File(_currentPhotoPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _currentPhotoPath == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  // Botões de Alterar e Remover Foto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gradientStart,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          onPressed: _showImageSourceDialog,
                          child: const Text(
                            'Alterar foto',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gradientStart,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          onPressed: _removePhoto,
                          child: const Text(
                            'Remover foto',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==================== NOME COM ÍCONE EDIT ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Nome do estudante',
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.edit, color: Colors.grey, size: 20),
                ],
              ),
            ),

            // ==================== DESCRIÇÃO EDITÁVEL ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Descrição do estudante',
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(Icons.edit, color: Colors.grey, size: 18),
                    ),
                  ],
                ),
              ),
            ),

            // ==================== DADOS ADICIONAIS ====================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dados Adicionais',
                  style: titleText,
                ),
              ),
            ),

            // Grid de Dados Adicionais
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // Linha 1: Idade e Peso
                  Row(
                    children: [
                      Expanded(
                        child: SimpleDataField(
                          label: 'Idade',
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            AgeInputFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SimpleDataField(
                          label: 'Peso (kg)',
                          controller: weightController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            WeightInputFormatter(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Linha 2: Gênero e Altura
                  Row(
                    children: [
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gênero',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black54,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  isExpanded: true,
                                  underline: Container(),
                                  items: ['Masculino', 'Feminino', 'Outro']
                                      .map((gender) => DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value ?? 'Masculino';
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SimpleDataField(
                          label: 'Altura (m)',
                          controller: heightController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            HeightInputFormatter(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==================== BOTÕES INFERIORES ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  // Botão Salvar Edições
                  SizedBox(
                    width: double.infinity,
                    child: _isSaving
                        ? const Center(
                            child: CircularProgressIndicator(color: primaryRed),
                          )
                        : MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GradientButton(
                              text: 'Salvar Edições',
                              onPressed: _saveChanges,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  // Botões Inativar e Excluir
                  Row(
                    children: [
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1C2A35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                            child: const Text(
                              'Inativar Aluno',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _deleteStudent,
                            child: const Text(
                              'Excluir aluno',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CARD DE DADOS ADICIONAIS ====================
class AdditionalDataField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const AdditionalDataField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            right: BorderSide(
              color: Colors.grey[300]!,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Digite o valor',
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SIMPLE DATA FIELD (NOVO) ====================
class SimpleDataField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const SimpleDataField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.2),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

// ==================== CARD DE DADOS ADICIONAIS (ANTIGO) ====================
class AdditionalDataCard extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onChanged;

  const AdditionalDataCard({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          right: BorderSide(
            color: Colors.grey[300]!,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: 'Digite o valor',
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
