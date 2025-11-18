import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'components.dart';
import '../models/client.dart';
import '../data/clients_database.dart';
import '../data/users_database.dart';

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

class StudentRegisterPage extends StatefulWidget {
  final int? codUser;
  final VoidCallback onSuccess;

  const StudentRegisterPage({
    super.key,
    this.codUser,
    required this.onSuccess,
  });

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedGender;
  File? _selectedImage;
  bool _isLoading = false;
  int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await DatabaseHelper.instance.getFirstUser();
      if (user != null) {
        // Como User não tem ID na estrutura atual, usamos a posição 0
        // Você pode precisar adicionar um campo ID ao modelo User
        setState(() {
          _currentUserId = 1; // Usando 1 como ID padrão do usuário
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar usuário: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      // Aqui você pode implementar a seleção de imagem
      // Por enquanto, deixamos como placeholder
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Funcionalidade de câmera em desenvolvimento')),
      );
    } catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _registerStudent() async {
    // Validação básica
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira o nome do aluno')),
      );
      return;
    }

    if (_currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: Usuário não identificado')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Parse dos valores numéricos
      final int? age = _ageController.text.isNotEmpty
          ? int.tryParse(_ageController.text)
          : null;
      final double? height = _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text)
          : null;
      final double? weight = _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null;

      // Criar cliente
      final client = Client(
        name: _nameController.text.trim(),
        desc: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        photoPath: _selectedImage?.path,
        age: age,
        height: height,
        weight: weight,
        gender: _selectedGender,
        codUser: _currentUserId!,
      );

      // Salvar no banco
      await ClientsDatabase.instance.insertClient(client);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aluno cadastrado com sucesso!')),
        );

        // Chamar callback de sucesso
        widget.onSuccess();

        // Voltar para a página anterior
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Erro ao registrar aluno: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar aluno: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
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

            // ==================== FOTO DO ALUNO ====================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          image: _selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey[600],
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_selectedImage != null)
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: _removeImage,
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
            ),

            // ==================== NOME DO ALUNO ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: TextField(
                controller: _nameController,
                decoration: defaultInputDecoration('Nome do aluno'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            // ==================== DESCRIÇÃO ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: defaultInputDecoration('Descrição do aluno'),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),

            // ==================== DADOS ADICIONAIS ====================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dados Adicionais',
                  style: titleText,
                ),
              ),
            ),

            // Dados Adicionais - Idade, Peso, Gênero, Altura
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
                          controller: _ageController,
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
                          controller: _weightController,
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
                                  value: _selectedGender,
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
                                      _selectedGender = value;
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  hint: const Text('Selecionar'),
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
                          controller: _heightController,
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

            // ==================== BOTÃO CADASTRAR ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: _isLoading
                  ? const CircularProgressIndicator(color: primaryRed)
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: double.infinity,
                        child: GradientButton(
                          text: 'Cadastrar Aluno',
                          onPressed: _registerStudent,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SIMPLE DATA FIELD ====================
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
