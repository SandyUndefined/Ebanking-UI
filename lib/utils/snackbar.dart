import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

floatingSnackBar(BuildContext context, String text) {
  ScaffoldMessengerState().hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text, style: primaryTextStyle(color: Colors.white)),
    behavior: SnackBarBehavior.floating,
  ));
}
