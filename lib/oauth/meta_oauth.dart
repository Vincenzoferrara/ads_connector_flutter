
import 'redirect_handler.dart';
import 'token_storage.dart';

class MetaOAuthFlow {
  Future<String?> startLogin() async {
    final redirect = await RedirectHandler.launchAndWait(
      authUrl: "https://www.facebook.com/v18.0/dialog/oauth?...",
      redirectScheme: "ads"
    );
    if (redirect != null) {
      await TokenStorage.saveToken("meta", redirect);
    }
    return redirect;
  }
}
