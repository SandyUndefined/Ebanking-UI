import 'package:apes/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

// ignore: must_be_immutable, camel_case_types
class Button extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;

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
  var validator;
  var autovalidateMode;
  var onChanged;
  var input;
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
      var this.validator,
      var this.onChanged,
      var this.autovalidateMode,
      var this.input,
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
      return TextFormField(
        controller: widget.mController,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        onChanged: widget.onChanged,
        inputFormatters: widget.input,
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
      return TextFormField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          validator: widget.validator,
          onChanged: widget.onChanged,
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

class PinEntryTextField extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField(
      {this.lastPin,
      this.fields: 4,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  late List<String?> _pin;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String?>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode?>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.fields, null,
        growable: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController? t) => t!.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController? tEditController) => tEditController!.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i]!.text = widget.lastPin![i];
      }
    }

    _focusNodes[i]!.addListener(() {
      if (_focusNodes[i]!.hasFocus) {}
    });

    return Container(
      width: widget.fieldWidth,
      margin: const EdgeInsets.only(right: 5.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textPrimaryColor,
            fontFamily: fontFamilyPrimaryGlobal,
            fontSize: 18),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
          counterText: "",
          border: widget.showFieldAsBox
              ? const OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: icon_color),
                )
              : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: icon_color),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: colorPrimary),
          ),
        ),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}
