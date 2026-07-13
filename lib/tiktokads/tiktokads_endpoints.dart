
class TikTokAdsEndpoints {
  static const base = "https://business-api.tiktok.com/open_api/v1.3";

  static String advertisers() => "$base/advertiser/get/";
  static String campaigns() => "$base/campaign/get/";
  static String adGroups() => "$base/adgroup/get/";
  static String ads() => "$base/ad/get/";
  static String reports() => "$base/report/integrated/get/";
}
