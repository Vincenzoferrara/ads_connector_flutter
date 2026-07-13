
class MetaEndpoints {
  static const graphBase = "https://graph.facebook.com/v18.0";

  static String meAdAccounts() => "$graphBase/me/adaccounts";
  static String adAccount(String id) => "$graphBase/$id";
  static String campaigns(String adAccountId) => "$graphBase/$adAccountId/campaigns";
  static String adSets(String adAccountId) => "$graphBase/$adAccountId/adsets";
  static String ads(String adAccountId) => "$graphBase/$adAccountId/ads";
  static String insights(String adAccountId) => "$graphBase/$adAccountId/insights";
  static String catalogs(String businessId) => "$graphBase/$businessId/product_catalogs";
  static String catalogItems(String catalogId) => "$graphBase/$catalogId/products";
}
