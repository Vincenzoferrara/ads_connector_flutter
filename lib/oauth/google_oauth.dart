
import 'redirect_handler.dart';
import 'token_storage.dart';

class GoogleOAuthFlow {
  Future<String?> startLogin() async {
    final redirect = await RedirectHandler.launchAndWait(
      authUrl: "https://accounts.google.com/o/oauth2/v2/auth?...",
      redirectScheme: "ads"
    );
    if (redirect != null) {
      await TokenStorage.saveToken("google", redirect);
    }
    return redirect;
  }
}
