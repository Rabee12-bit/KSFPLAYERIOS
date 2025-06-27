import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/file_service.dart';

class KSFFilePicker extends StatelessWidget {
  final void Function(String wavPath) onFileProcessed;
  const KSFFilePicker({required this.onFileProcessed, Key? key})
    : super(key: key);

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ksf'],
    );
    if (result != null && result.files.single.path != null) {
      final wavPath = await FileService.convertKSFtoWAV(
        result.files.single.path!,
      );
      if (wavPath != null) {
        onFileProcessed(wavPath);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('فشل في معالجة الملف')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.folder_open),
      label: Text('اختر ملف KSF'),
      onPressed: () => _pickFile(context),
    );
  }
}
