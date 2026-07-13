
import 'dart:convert';
import 'package:ads_connector/common/http_client.dart';
import 'package:ads_connector/common/logger.dart';
import 'package:ads_connector/common/rate_limit.dart';
import 'googleads_endpoints.dart';
import 'googleads_utils.dart';

class GoogleAdsClient {
  final String accessToken;
  final _http = HttpClient();
  final _rate = RateLimitManager();

  GoogleAdsClient(this.accessToken);

  Future<dynamic> listAccountsRaw() async {
    return await _post(GoogleAdsEndpoints.customersList(), {});
  }

  Future<dynamic> fetchCampaignsRaw(String customerId, {List<String>? fields}) async {
    final query = GoogleAdsUtils.buildQuery(
      fields ?? ["campaign.id","campaign.name","metrics.impressions","metrics.clicks","metrics.cost_micros"],
      resource: "campaign"
    );
    return await _post(GoogleAdsEndpoints.campaigns(customerId), {"query": query});
  }

  Future<dynamic> _post(String url, Map body) async {
    return await _rate.execute(() async {
      Logger.log("[GOOGLE ADS] POST $url");
      final res = await _http.post(url,
        headers: {"Authorization":"Bearer $accessToken","Content-Type":"application/json"},
        body: jsonEncode(body)
      );
      return jsonDecode(res);
    });
  }
}
