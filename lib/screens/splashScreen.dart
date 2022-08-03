import 'package:apes/screens/walkThrough.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/strings.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WalkThrough()));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(-0.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Image(
              image: AssetImage(logo),
              height: 150,
              width: 250,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
