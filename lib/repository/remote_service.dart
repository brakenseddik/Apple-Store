import 'package:http/http.dart' as http;

class Repository {
  String baseUrl = "http://192.168.1.2:8000/api/";

  httpGet(String api) async {
    return await http
        .get(Uri.parse(this.baseUrl + api))
        .timeout(Duration(seconds: 10));
  }

  httpPost(String api, Map data) async {
    return await http.post(Uri.parse(baseUrl + api), body: data);
  }

  httpGetById(String api, int id) async {
    return await http
        .get(Uri.parse(baseUrl + api + "/" + id.toString()))
        .timeout(Duration(seconds: 10));
  }
}
