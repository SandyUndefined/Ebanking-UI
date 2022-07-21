import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String baseUrl = "https://aeps.bharataeps.com";
  var status;
  var token;

  login(String phn, String password) async {
    String uri = "$baseUrl/User_Login";
    try {
      return await http.post(Uri.parse(uri), headers: {
        'Accept': 'application/json'
      }, body: {
        "number": "7001265296",
        "password": "Amit@123",
        "long": "88.3661246",
        "lati": "26.7112995"
      });
    } catch (e) {
      return e;
    }
  }

  saveKey(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
}
