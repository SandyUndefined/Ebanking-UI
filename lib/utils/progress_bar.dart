import 'package:apes/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

progressBar(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.all(0.0),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                16.width,
                const CircularProgressIndicator(
                  backgroundColor: Color(0xffD6D6D6),
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
                16.width,
                Text(
                  "Please Wait....",
                  style: primaryTextStyle(color: textColorPrimary),
                ),
              ],
            ),
          ),
        );
      });
}
