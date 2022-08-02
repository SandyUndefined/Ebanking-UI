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

  login(String phn, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await getLocation();
    String uri = "$baseUrl/User_Login";
    try {
      http.Response response = await http.post(Uri.parse(uri), headers: {
        'Accept': 'application/json'
      }, body: {
        "number": phn,
        "password": password,
        "long": long,
        "lati": lati
      });
      prefs.setString('cookie', response.headers['set-cookie']!);
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  register(
      String name, String email, String phn, String pass, String state) async {
    await getLocation();
    String uri = "$baseUrl/Register_new";
    try {
      http.Response response = await http.post(Uri.parse(uri), headers: {
        'Accept': 'application/json'
      }, body: {
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
      // updateCookie(response);
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  verifyLoginOtp(String otp) async {
    print(otp);
    Map<String, String> authHeaders = {};
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('key'));
    String uri = "$baseUrl/verify_login_otp";

    try {
      http.Response response = await http.post(Uri.parse(uri), headers: {
        'Accept': 'application/json'
      }, body: {
        "otp": otp,
        "key": prefs.getString('key'),
      });
      prefs.setString('header', response.headers.toString());
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  saveData(String name, String phn, String email, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('mobile', phn);
    prefs.setString('email', email);
    prefs.setString('state', "West Bengal");
    prefs.setInt('id', id);
  }

  saveKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', key);
  }

  saveLoginKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authKey', key);
  }

  saveSessionId(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sessionKey', token);
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('cookie').toString();
    // String key = prefs.getString('key').toString();
    String cookie = prefs.getString('cookie').toString();
    String key = prefs.getString('authKey').toString();
    String session = prefs.getString('sessionKey').toString();
    String uri = "https://aeps.bharataeps.com/api/User_Bal";
    var headers = {
      'Accept': 'application/json',
      'Authorization': key,
      // 'Cookie': cookie,
      'Token': session
    };
    print(headers);
    try {
      http.Response response = await http.get(Uri.parse(uri), headers: headers);
      return response.body;
    } catch (e) {
      print("this is error $e");
      return e;
    }
  }

  // getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? _token = prefs.getString('cookie');
  //   String uri = "$baseUrlUser/user_bal";
  //   try {
  //     http.Response response = await http.get(Uri.parse(uri), headers: {
  //       'Accept': 'application/json;charset=UTF-8',
  //       'Cookie': _token!,
  //       'Content-type': 'application/json'
  //     });
  //     print("this is header");
  //     print(response.headers);
  //     return response.body;
  //   } catch (e) {
  //     return e;
  //   }
  // }

  logout() async {
    String uri = "$baseUrlUser/logout";
    try {
      http.Response response = await http
          .get(Uri.parse(uri), headers: {'Accept': 'application/json'});
      print(response);
      return response.statusCode;
    } catch (e) {
      return e;
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lati = position.latitude.toString();
  }
}
