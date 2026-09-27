import 'dart:io';

import 'package:file_picker/file_picker.dart';

enum FileExtension { pdf, jpg, jpeg, png }

abstract final class FilePickerUtil {
  static File? _firstFile(FilePickerResult? result) {
    final path = result?.files.firstOrNull?.path;
    return path != null ? File(path) : null;
  }

  static Future<File?> pickVideo() async {
    final result = await FilePicker.pickFiles(type: FileType.video);
    return _firstFile(result);
  }

  static Future<File?> pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return _firstFile(result);
  }

  static Future<List<File>> pickFiles({
    required List<FileExtension> allowedExtensions,
  }) async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions.map((e) => e.name).toList(),
    );
    if (result == null || result.files.isEmpty) return [];
    return result.files
        .where((file) => file.path != null)
        .map((file) => File(file.path!))
        .toList();
  }
}