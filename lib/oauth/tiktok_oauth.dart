
import 'redirect_handler.dart';
import 'token_storage.dart';

class TikTokOAuthFlow {
  Future<String?> startLogin() async {
    final redirect = await RedirectHandler.launchAndWait(
      authUrl: "https://www.tiktok.com/auth/authorize?...",
      redirectScheme: "ads"
    );
    if (redirect != null) {
      await TokenStorage.saveToken("tiktok", redirect);
    }
    return redirect;
  }
}
