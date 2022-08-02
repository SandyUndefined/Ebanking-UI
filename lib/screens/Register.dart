import 'dart:convert';

import 'package:apes/model/auth.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/progress_bar.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordVisible = false;
  bool isRemember = false;
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String _fullName = '';
  String _email = '';
  String _phn = '';
  String _pass = '';
  String _repass = '';
  String _key = '';
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  Future<void> _submit() async {
    progressBar(context);
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_fullName);
      widget.onSubmit(_email);
      widget.onSubmit(_phn);
      widget.onSubmit(_pass);
      widget.onSubmit(_repass);
    }

    var data =
        await Auth().register(_fullName, _email, _phn, _pass, "West Bengal");
    print(data);
    if (data['status'] == 'err') {
      Navigator.pop(context);
      print(data['result']);
    } else if (data['status'] == 'success') {
      Auth().saveData(data["user"]["NAME"], data["user"]["MOBILE"],
          data["user"]["USER_LOGIN"], data["user"]["ID"]);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/register-success');
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(White);
    return Scaffold(
        body: Observer(
      builder: (_) => SingleChildScrollView(
        child: Container(
          color: context.scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              /*back icon*/
              SafeArea(
                child: Container(
                  color: context.scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              /*heading*/
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(lbl_sign_up_header,
                        maxLines: 2,
                        style:
                            boldTextStyle(size: 22, color: textPrimaryColor)),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(lbl_sign_in,
                          maxLines: 2,
                          style: boldTextStyle(
                              size: 22, color: textSecondaryColor)),
                    )
                  ],
                ),
              ),
              /*content*/
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(lbl_fullName, style: primaryTextStyle(size: 16)),
                      EditTextField(
                        isPassword: false,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if ((!nameRegExp.hasMatch(text)) &&
                              (text.length < 6)) {
                            // check for special char
                            return 'Enter a valid name';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _fullName = text),
                      ),
                      const SizedBox(height: 25),
                      Text(hint_email, style: primaryTextStyle(size: 16)),
                      EditTextField(
                        isPassword: false,
                        inputType: TextInputType.emailAddress,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        validator: (text) {
                          String pattern =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$";
                          RegExp regex = RegExp(pattern);
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (!regex.hasMatch(text)) {
                            // check for email validation
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _email = text),
                      ),
                      const SizedBox(height: 25),
                      Text(hint_phone, style: primaryTextStyle(size: 16)),
                      EditTextField(
                        input: [FilteringTextInputFormatter.digitsOnly],
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        isPassword: false,
                        inputType: TextInputType.number,
                        decoration: country_code,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length != 10) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _phn = text),
                      ),
                      const SizedBox(height: 25),
                      Text(hint_password, style: primaryTextStyle(size: 16)),
                      EditTextField(
                        isSecure: true,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 6) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _pass = text),
                      ),
                      const SizedBox(height: 25),
                      Text(hint_re_password, style: primaryTextStyle(size: 16)),
                      EditTextField(
                        isSecure: true,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (_pass != text) {
                            return 'Password doesn\'t match';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _repass = text),
                      ),
                      const SizedBox(height: 50),
                      Button(
                          textContent: lbl_sign_up,
                          onPressed: _fullName.isNotEmpty &&
                                  _email.isNotEmpty &&
                                  _phn.isNotEmpty &&
                                  _pass.isNotEmpty
                              ? _submit
                              : null),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lbl_already,
                            style: boldTextStyle(
                                size: 18, color: textSecondaryColor),
                          ),
                          GestureDetector(
                            child: Center(
                                child: Text(lbl_sign_in,
                                    style: primaryTextStyle(
                                        color: colorPrimary, size: 16))),
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
