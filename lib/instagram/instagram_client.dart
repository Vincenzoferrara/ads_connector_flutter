
import 'dart:convert';
import 'package:ads_connector/common/http_client.dart';
import 'package:ads_connector/common/logger.dart';
import 'package:ads_connector/common/rate_limit.dart';
import 'instagram_endpoints.dart';
import 'instagram_utils.dart';

class InstagramClient {
  final String accessToken;
  final _http = HttpClient();
  final _rate = RateLimitManager();

  InstagramClient(this.accessToken);

  Future<dynamic> fetchConnectedPages() async {
    return await _get(InstagramEndpoints.meAccounts());
  }

  Future<dynamic> fetchInstagramUser(String pageId) async {
    return await _get(InstagramEndpoints.igUser(pageId));
  }

  Future<dynamic> fetchMedia(String igUserId) async {
    return await _get(InstagramEndpoints.igMedia(igUserId));
  }

  Future<dynamic> fetchMediaInsights(String mediaId, {Map<String,dynamic>? params}) async {
    final base = InstagramEndpoints.igMediaInsights(mediaId);
    final q = InstagramUtils.buildQuery(params);
    return await _get("$base?$q");
  }

  Future<dynamic> fetchUserInsights(String igUserId, {Map<String,dynamic>? params}) async {
    final base = InstagramEndpoints.igUserInsights(igUserId);
    final q = InstagramUtils.buildQuery(params);
    return await _get("$base?$q");
  }

  Future<dynamic> _get(String url) async {
    return await _rate.execute(() async {
      Logger.log("[IG] GET $url");
      final res = await _http.get(url, headers: {"Authorization":"Bearer $accessToken"});
      return jsonDecode(res);
    });
  }
}
