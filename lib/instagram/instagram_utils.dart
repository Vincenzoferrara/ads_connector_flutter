
class InstagramUtils {
  static String buildQuery(Map<String,dynamic>? params){
    if(params == null) return "";
    return params.entries.map((e){
      return "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}";
    }).join("&");
  }
}
