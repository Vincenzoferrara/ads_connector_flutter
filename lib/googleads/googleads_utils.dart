
class GoogleAdsUtils {
  static String buildQuery(List<String> fields, {String resource="campaign"}) {
    final f = fields.join(", ");
    return "SELECT $f FROM $resource";
  }
}
