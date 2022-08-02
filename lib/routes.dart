import 'package:apes/screens/Register.dart';
import 'package:apes/screens/homepage.dart';
import 'package:apes/screens/login.dart';
import 'package:apes/screens/otp.dart';
import 'package:apes/screens/register_success.dart';
import 'package:apes/screens/splashScreen.dart';
import 'package:apes/screens/walkThrough.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    '/splashScreen': (context) => const SplashScreen(),
    '/walkThrough': (context) => const WalkThrough(),
    '/login': (context) => Login(
          onSubmit: (String value) {
            print(value);
          },
        ),
    '/register-success': (context) => const RegisterSuccess(),
    '/register': (context) => Register(
          onSubmit: (String value) {
            print(value);
          },
        ),
    '/otp': (context) => Otp(
          onSubmit: (String value) {
            print(value);
          },
        ),
    '/home': (context) => const HomePage(),
  };
}
