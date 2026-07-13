
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String provider, String token) async {
    await _storage.write(key: provider, value: token);
  }

  static Future<String?> loadToken(String provider) async {
    return await _storage.read(key: provider);
  }

  static Future<void> clearToken(String provider) async {
    await _storage.delete(key: provider);
  }
}
