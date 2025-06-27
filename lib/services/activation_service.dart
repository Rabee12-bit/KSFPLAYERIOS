import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math';

class ActivationService {
  static final _storage = FlutterSecureStorage();
  static const _key = 'activation';

  static Future<bool> isActivated() async {
    final value = await _storage.read(key: _key);
    return value == '1';
  }

  static String generateRequestCode() {
    // يمكن تخصيصه ليعتمد على الجهاز
    return Random().nextInt(999999).toString().padLeft(6, '0');
  }

  static Future<bool> activate(String code) async {
    // تحقق من الكود (يجب استبدال المنطق بآلية المطور)
    if (code == '123456') {
      await _storage.write(key: _key, value: '1');
      return true;
    }
    return false;
  }
}
