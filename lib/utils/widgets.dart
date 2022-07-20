import 'package:apes/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

// ignore: must_be_immutable, camel_case_types
class Button extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  Button({Key? key, required this.textContent, required this.onPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

// ignore: camel_case_types
class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: const EdgeInsets.all(0.0),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: <Color>[colorPrimary, colorPrimaryDark]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/placeholder.jpg', fit: BoxFit.cover);

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

class EditTextField extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  var inputType;
  var decoration;
  TextEditingController? mController;

  VoidCallback? onPressed;

  EditTextField(
      {var this.fontSize = 20.0,
      var this.textColor = textColorSecondary,
      var this.isPassword = true,
      var this.isSecure = false,
      var this.text = "",
      var this.inputType = TextInputType.text,
      var this.mController,
      var this.decoration,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextFieldState();
  }
}

class EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextField(
        controller: widget.mController,
        keyboardType: widget.inputType,
        obscureText: widget.isPassword,
        cursorColor: colorPrimary,
        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: textPrimaryColor,
            fontFamily: widget.fontFamily),
        decoration: InputDecoration(
          prefixText: widget.decoration,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: icon_color),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: colorPrimary),
          ),
        ),
      );
    } else {
      return TextField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          cursorColor: colorPrimary,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: TextColorPrimary,
              fontFamily: widget.fontFamily),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: icon_color),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: icon_color),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: colorPrimary),
            ),
          ));
    }
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(width: 16.0, color: colorPrimary),
        ),
      ),
      const SizedBox(height: 16),
      Text(description,
          style: boldTextStyle(color: textPrimaryColor, size: 20),
          maxLines: 2,
          textAlign: TextAlign.center)
    ],
  );
}

Widget shareIcon(String iconPath, Color tintColor) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}
