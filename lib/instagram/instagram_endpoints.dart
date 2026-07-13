
class InstagramEndpoints {
  static const graphBase = "https://graph.facebook.com/v18.0";

  static String meAccounts() => "$graphBase/me/accounts";
  static String igUser(String pageId) => "$graphBase/$pageId";
  static String igMedia(String igUserId) => "$graphBase/$igUserId/media";
  static String igMediaInsights(String mediaId) => "$graphBase/$mediaId/insights";
  static String igUserInsights(String igUserId) => "$graphBase/$igUserId/insights";
}
