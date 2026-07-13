
import 'dart:convert';
import 'package:ads_connector/common/http_client.dart';
import 'package:ads_connector/common/logger.dart';
import 'package:ads_connector/common/rate_limit.dart';
import 'tiktokads_endpoints.dart';

class TikTokAdsClient {
  final String accessToken;
  final _http = HttpClient();
  final _rate = RateLimitManager();

  TikTokAdsClient(this.accessToken);

  Future<dynamic> fetchAdvertisersRaw() async {
    return await _post(TikTokAdsEndpoints.advertisers(), {});
  }

  Future<dynamic> fetchCampaignsRaw(String advertiserId) async {
    return await _post(TikTokAdsEndpoints.campaigns(), {
      "advertiser_id": advertiserId
    });
  }

  Future<dynamic> fetchAdGroupsRaw(String advertiserId) async {
    return await _post(TikTokAdsEndpoints.adGroups(), {
      "advertiser_id": advertiserId
    });
  }

  Future<dynamic> fetchAdsRaw(String advertiserId) async {
    return await _post(TikTokAdsEndpoints.ads(), {
      "advertiser_id": advertiserId
    });
  }

  Future<dynamic> fetchReportsRaw(String advertiserId, Map<String,dynamic>? params) async {
    final p = <String, dynamic>{"advertiser_id": advertiserId};
    if(params != null) p.addAll(params);
    return await _post(TikTokAdsEndpoints.reports(), p);
  }

  Future<dynamic> _post(String url, Map<String, dynamic> body) async {
    return await _rate.execute(() async {
      Logger.log("[TIKTOK ADS] POST $url");
      final res = await _http.post(url,
        headers: <String, String>{
          "Access-Token": accessToken,
          "Content-Type":"application/json"
        },
        body: jsonEncode(body)
      );
      return res;
    });
  }
}
