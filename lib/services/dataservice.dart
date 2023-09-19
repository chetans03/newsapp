import 'dart:convert';

import 'package:napp/model/apiModel.dart';
import 'package:http/http.dart' as http;

class Tpnews {
  List<dynamic> topnews = [];
  Future<Newsmodel> fetchtopnews() async {
    final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=br&apiKey=b2341dbf30e642e696d122a0bee05c26"),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body.toString());
      topnews = body["articles"];
      return Newsmodel.fromJson(body);
    }
    throw Exception("error");
  }
}
