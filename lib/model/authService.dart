import 'package:apes/utils/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  late Position position;
  String long = "";
  String lati = "";

  String baseUrl = "https://aeps.bharataeps.com";
  var status;
  var token;

  var header = {'Accept': 'application/json'};

  login(String phn, String password) async {
    String uri = "$baseUrl/User_Login";
    try {
      return await http.post(Uri.parse(uri), headers: header, body: {
        "number": "7001265296",
        "password": "Amit@123",
        "long": long,
        "lati": lati
      });
    } catch (e) {
      return e;
    }
  }

  register(
      String name, String email, String phn, String pass, String state) async {
    print("enter into the register");
    String uri = "$baseUrl/Register_new";
    print(uri);
    try {
      return await http.post(Uri.parse(uri), headers: header, body: {
        "name": name,
        "mobile": phn,
        "email": email,
        "state": state,
        "cpass": pass,
        "long": long,
        "lati": lati,
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

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);
    long = position.longitude.toString();
    lati = position.latitude.toString();
  }
}
