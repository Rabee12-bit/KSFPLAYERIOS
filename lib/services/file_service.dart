import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<String?> convertKSFtoWAV(String ksfPath) async {
    final file = File(ksfPath);
    final bytes = await file.readAsBytes();
    if (bytes.length < 2) return null;
    final wavBytes = bytes.sublist(1); // تخطي أول بايت
    final dir = await getTemporaryDirectory();
    final wavPath = '${dir.path}/converted.wav';
    final wavFile = File(wavPath);
    await wavFile.writeAsBytes(wavBytes);
    return wavPath;
  }
}
