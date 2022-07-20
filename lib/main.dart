import 'package:apes/screens/splashScreen.dart';
import 'package:apes/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:apes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Apes',
          home: const SplashScreen(),
          theme: AppThemeData.lightTheme,
          routes: routes(),
          navigatorKey: navigatorKey,
          scrollBehavior: SBehavior()),
    );
  }
}
