import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  late final Uri url;
  NetworkHelper(this.url);

  Future getBodyData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      return response.statusCode;
    }
  }
}
