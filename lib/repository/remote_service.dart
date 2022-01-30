import 'package:http/http.dart' as http;

class Repository {
  String baseUrl = "http://192.168.1.2:8000/api/";

  httpGet(String api) async {
    return await http
        .get(Uri.parse(this.baseUrl + api))
        .timeout(Duration(milliseconds: 5000));
  }

  httpPost(String api, data) async {
    return await http
        .post(Uri.parse(baseUrl + api), body: data)
        .timeout(Duration(milliseconds: 5000));
  }

  httpGetById(String api, int id) async {
    return await http
        .get(Uri.parse(baseUrl + api + "/" + id.toString()))
        .timeout(Duration(milliseconds: 5000));
  }
}
