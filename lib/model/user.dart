import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String baseURL = "https://aeps.bharataeps.com/api/operator";

  fetchOperator() async {
    final prefs = await SharedPreferences.getInstance();
    String key = prefs.getString('authKey').toString();
    String session = prefs.getString('sessionKey').toString();
    try {
      http.Response response = await http.get(Uri.parse(baseURL), headers: {
        'Accept': 'application/json',
        'Authorization': key,
        'Token': session
      });
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  getPrepaid() async {
    var data = await fetchOperator();
    var prepaidList = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i]["SERVICETYPE"] == "Prepaid") {
        prepaidList.add(data[i]);
      }
    }
    return prepaidList;
  }
}
