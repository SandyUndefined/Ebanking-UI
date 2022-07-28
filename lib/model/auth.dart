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
  Map<String, String> headers = {'Accept': 'application/json'};

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    print("this is rawCookie $rawCookie");
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  // _getKey() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('key');
  //   print("this is Key $token");
  // }

  // getSessionId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   sessionId = prefs.getString('SessionID');
  //   print("this is seesion ID $sessionId");
  // }

  // _getCSRF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   csrf = prefs.getString('csrf');
  //   print("this is seesion ID $csrf");
  // }

  // _setHeaders() => {'Accept': 'application/json'};

  login(String phn, String password) async {
    await getLocation();
    String uri = "$baseUrl/User_Login";
    try {
      http.Response response = await http.post(Uri.parse(uri),
          headers: headers,
          body: {
            "number": phn,
            "password": password,
            "long": long,
            "lati": lati
          });
      updateCookie(response);
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  // saveCSRF(String csrf) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('csrf', csrf);
  // }

  register(
      String name, String email, String phn, String pass, String state) async {
    await getLocation();
    String uri = "$baseUrl/Register_new";
    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: {
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
      updateCookie(response);
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  verifyLoginOtp(String otp) async {
    final prefs = await SharedPreferences.getInstance();

    print(prefs.getString('key'));
    String uri = "$baseUrl/verify_login_otp";

    try {
      http.Response response =
          await http.post(Uri.parse(uri), headers: headers, body: {
        "otp": otp,
        "key": prefs.getString('key'),
      });
      updateCookie(response);
      return json.decode(response.body);
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

  // saveKey(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('key', key);
  // }

  // saveSessionId(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('SessionID', key);
  //   print(prefs.getString('SessionID'));
  // }

  getData() async {
    String uri = "$baseUrlUser/user_bal";
    try {
      http.Response response = await http.get(Uri.parse(uri), headers: headers);
      updateCookie(response);
      return response.body;
    } catch (e) {
      return e;
    }
  }

  logout() async {
    String uri = "$baseUrlUser/user_bal";
    try {
      http.Response response = await http.get(Uri.parse(uri), headers: headers);
      updateCookie(response);
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  // _setAuthHeaders() => {
  //       'Accept': 'application/json',
  //       'Connection': 'keep-alive',
  //       // 'Authorization': 'Bearer $token',
  //     };

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lati = position.latitude.toString();
  }
}
