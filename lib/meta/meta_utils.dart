
class MetaUtils {
  static String buildQuery(Map<String,dynamic>? params){
    if(params == null) return "";
    return params.entries.map((e){
      if(e.value is Map) return "";
      return "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}";
    }).join("&");
  }
}
