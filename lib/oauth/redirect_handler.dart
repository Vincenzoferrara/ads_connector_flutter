import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

class RedirectHandler {
  static final AppLinks _appLinks = AppLinks();
  static Future<String?> launchAndWait({
    required String authUrl,
    required String redirectScheme,
  }) async {
    final completer = Completer<String?>();
    late final StreamSubscription sub;

    sub = _appLinks.uriLinkStream.listen((uri) {
      if (uri != null && uri.scheme == redirectScheme) {
        completer.complete(uri.toString());
        sub.cancel();
      }
    });

    await launchUrl(Uri.parse(authUrl), mode: LaunchMode.externalApplication);

    return completer.future;
  }
}
