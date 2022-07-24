import 'package:apes/utils/colors.dart';
import 'package:apes/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  double circleSize = 140;
  double iconSize = 108;

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.popAndPushNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(acc_success, style: boldTextStyle(size: 24)),
            const SizedBox(height: 18),
            successAnimation(context),
            const SizedBox(height: 22),
            Text(
              verify_acc,
              style: primaryTextStyle(size: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  successAnimation(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: const BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: checkAnimation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Icon(Icons.check_rounded,
                    color: Colors.white, size: iconSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
