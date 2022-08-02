import 'package:apes/screens/homepage.dart';
import 'package:apes/screens/splashScreen.dart';
import 'package:apes/utils/geolocator.dart';
import 'package:apes/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:apes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getPref();
    askPermission();
  }

  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("value")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Apes',
          home: const CheckAuth(),
          theme: AppThemeData.lightTheme,
          routes: routes(),
          navigatorKey: navigatorKey,
          scrollBehavior: SBehavior()),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var key = localStorage.getString('authKey');
    print(key);
    if (key != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = const HomePage();
    } else {
      child = const SplashScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}
