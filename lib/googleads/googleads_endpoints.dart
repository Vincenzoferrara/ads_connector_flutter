
class GoogleAdsEndpoints {
  static const base = "https://googleads.googleapis.com/v14";

  static String customersList() => "$base/customers:listAccessibleCustomers";
  static String customer(String customerId) => "$base/customers/$customerId";
  static String campaigns(String customerId) => "$base/customers/$customerId/googleAds:search";
}
