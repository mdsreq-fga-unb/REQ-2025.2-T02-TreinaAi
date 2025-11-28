import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  static final ImageRepository instance = ImageRepository._internal();
  ImageRepository._internal();

  final ImagePicker _imagePicker = ImagePicker();

  /// Seleciona uma imagem da galeria
  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Erro ao selecionar imagem da galeria: $e');
      return null;
    }
  }

  /// Seleciona uma imagem da câmera
  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Erro ao tirar foto: $e');
      return null;
    }
  }

  /// Salva a imagem no diretório local e retorna o caminho
  Future<String?> saveImageLocally(File imageFile, int codClient) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/client_images');

      // Cria o diretório se não existir
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      // Gera nome único para a imagem
      final fileName = 'client_${codClient}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = path.join(imagesDir.path, fileName);

      // Copia a imagem para o diretório local
      final savedImage = await imageFile.copy(savedImagePath);

      debugPrint('Imagem salva em: ${savedImage.path}');
      return savedImage.path;
    } catch (e) {
      debugPrint('Erro ao salvar imagem localmente: $e');
      return null;
    }
  }

  /// Remove a imagem do armazenamento local
  Future<bool> deleteImageLocally(String imagePath) async {
    try {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
        debugPrint('Imagem removida: $imagePath');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Erro ao remover imagem: $e');
      return false;
    }
  }

  /// Verifica se uma imagem existe
  Future<bool> imageExists(String imagePath) async {
    try {
      if (imagePath.isEmpty) return false;
      final imageFile = File(imagePath);
      return await imageFile.exists();
    } catch (e) {
      debugPrint('Erro ao verificar existência da imagem: $e');
      return false;
    }
  }
}
