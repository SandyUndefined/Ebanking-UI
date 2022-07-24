import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  String baseUrl = "https://aeps.bharataeps.com";
  String baseUrlUser = "https://aeps.bharataeps.com/Retailer";

  late Position position;
  String long = "";
  String lati = "";

  var status;
  var key;
  var csrf;

  _getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    key = prefs.getString('key');
  }

  _getCSRF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    csrf = prefs.getString('csrf');
    print(csrf);
  }

  _setHeaders() => {'Accept': 'application/json'};

  login(String phn, String password) async {
    await getLocation();
    String uri = "$baseUrl/User_Login";
    try {
      return await http.post(Uri.parse(uri), headers: _setHeaders(), body: {
        "number": phn,
        "password": password,
        "long": long,
        "lati": lati
      });
    } catch (e) {
      return e;
    }
  }

  saveCSRF(String csrf) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('csrf', csrf);
  }

  register(
      String name, String email, String phn, String pass, String state) async {
    await getLocation();

    String uri = "$baseUrl/Register_new";
    try {
      return await http.post(Uri.parse(uri), headers: _setHeaders(), body: {
        "name": name,
        "mobile": phn,
        "email": email,
        "state": state,
        "cpass": pass,
        "long": long,
        "lati": lati,
        "ref_id": "ADMIN",
        "device": "APP",
      });
    } catch (e) {
      return e;
    }
  }

  verifyLoginOtp(String otp) async {
    final prefs = await SharedPreferences.getInstance();

    print(prefs.getString('key'));
    String uri = "$baseUrl/verify_login_otp";

    try {
      return await http.post(Uri.parse(uri), headers: _setHeaders(), body: {
        "otp": otp,
        "key": prefs.getString('key'),
        "long": long,
        "lati": lati,
      });
    } catch (e) {
      return e;
    }
  }

  getDetails() async {}

  saveData(String name, String phn, String email, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('mobile', phn);
    prefs.setString('email', email);
    prefs.setString('state', "West Bengal");
    prefs.setInt('id', id);

    // print(prefs.getString('key'));
    // print(prefs.getString('mobile'));
  }

  saveKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', key);
  }

  getData() async {
    await _getCSRF();
    print(_setAuthHeaders());
    String uri = "$baseUrlUser/user_bal";
    try {
      return await http.get(Uri.parse(uri), headers: _setAuthHeaders());
    } catch (e) {
      return e;
    }
  }

  _setAuthHeaders() =>
      {'Accept': 'application/json', 'Authorization': 'Bearer $key'};

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lati = position.latitude.toString();
  }
}
