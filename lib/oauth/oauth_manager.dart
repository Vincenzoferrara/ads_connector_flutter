
import 'token_storage.dart';
import 'meta_oauth.dart';
import 'google_oauth.dart';
import 'tiktok_oauth.dart';

class OAuthManager {
  static Future<String?> loginMeta() async {
    return await MetaOAuthFlow().startLogin();
  }

  static Future<String?> loginGoogle() async {
    return await GoogleOAuthFlow().startLogin();
  }

  static Future<String?> loginTikTok() async {
    return await TikTokOAuthFlow().startLogin();
  }

  static Future<String?> loadSavedToken(String provider) async {
    return await TokenStorage.loadToken(provider);
  }

  static Future<void> clearSavedToken(String provider) async {
    await TokenStorage.clearToken(provider);
  }

  static Future<String?> getValidToken(String provider) async {
    final token = await TokenStorage.loadToken(provider);
    return token;
  }
}
