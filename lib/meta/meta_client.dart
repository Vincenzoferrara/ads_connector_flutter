
import 'dart:convert';
import 'package:ads_connector/common/http_client.dart';
import 'package:ads_connector/common/logger.dart';
import 'package:ads_connector/common/rate_limit.dart';
import 'meta_endpoints.dart';
import 'meta_utils.dart';

class MetaClient {
  final String accessToken;
  final _http = HttpClient();
  final _rate = RateLimitManager();

  MetaClient(this.accessToken);

  Future<dynamic> fetchAdAccountsRaw() async {
    return await _get(MetaEndpoints.meAdAccounts());
  }

  Future<dynamic> fetchCampaignsRaw(String adAccountId) async {
    return await _get(MetaEndpoints.campaigns(adAccountId));
  }

  Future<dynamic> fetchAdSetsRaw(String adAccountId) async {
    return await _get(MetaEndpoints.adSets(adAccountId));
  }

  Future<dynamic> fetchAdsRaw(String adAccountId) async {
    return await _get(MetaEndpoints.ads(adAccountId));
  }

  Future<dynamic> fetchInsightsRaw(String adAccountId, {Map<String,dynamic>? params}) async {
    final base = MetaEndpoints.insights(adAccountId);
    final q = MetaUtils.buildQuery(params);
    return await _get("$base?$q");
  }

  Future<dynamic> fetchBreakdownRaw(String adAccountId, String breakdown) async {
    final base = MetaEndpoints.insights(adAccountId);
    final q = "breakdowns=$breakdown";
    return await _get("$base?$q");
  }

  Future<dynamic> fetchCatalogsRaw(String businessId) async {
    return await _get(MetaEndpoints.catalogs(businessId));
  }

  Future<dynamic> fetchCatalogItemsRaw(String catalogId) async {
    return await _get(MetaEndpoints.catalogItems(catalogId));
  }

  Future<dynamic> _get(String url) async {
    return await _rate.execute(() async {
      Logger.log("[META] GET $url");
      final res = await _http.get(url, headers: {"Authorization":"Bearer $accessToken"});
      return jsonDecode(res);
    });
  }
}
