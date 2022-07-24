import 'dart:convert';
import 'package:apes/model/Api.dart';
import 'package:apes/model/auth.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/geolocator.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:apes/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  bool? isRemember = false;
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String _phn = '';
  String _pass = '';

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  Future<void> _submit() async {
    print("asdadad");
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_phn);
      widget.onSubmit(_pass);
    }
    var response = await Auth().login(_phn, _pass);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == "OTP") {
        print(data['status'] == "OTP");
        Auth().saveData(data["user"]["NAME"], data["user"]["MOBILE"],
            data["user"]["USER_LOGIN"], data["user"]["ID"]);
        Auth().saveKey(data["SESSION_ID"]);
        Auth().saveCSRF(data["csrf"]);
        Navigator.pushNamed(context, '/otp');
      } else if (data['satuts'] == 'err') {
        print(data['result']);
      } else if (data['status'] == 'success') {
        Auth().saveData(data["user"]["NAME"], data["user"]["MOBILE"],
            data["user"]["USER_LOGIN"], data["user"]["ID"]);
        Auth().saveKey(data["SESSION_ID"]);
        Auth().saveCSRF(data["csrf"]);
        Navigator.pushNamed(context, '/home');
      } else if (data['status'] == 'err_pwd') {
        print("password wrong");
      } else if (data['status'] == 'not_exists') {
        print("User not exists");
      } else if (data['status'] == 'block') {
        print("Account blocked");
      }
    } else {
      print(response.statusCode);
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
                      Text(lbl_sign_in_header,
                          maxLines: 2,
                          style:
                              boldTextStyle(size: 22, color: textPrimaryColor)),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          lbl_sign_up,
                          maxLines: 2,
                          style: boldTextStyle(
                              size: 18, color: textSecondaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                /*content*/
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            return null;
                          },
                          onChanged: (text) => setState(() => _pass = text),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              focusColor: colorPrimary,
                              activeColor: colorPrimary,
                              value: isRemember,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRemember = value;
                                });
                              },
                            ),
                            Text(lbl_remember,
                                style: primaryTextStyle(
                                    size: 16, color: textColorSecondary))
                          ],
                        ),
                        const SizedBox(height: 18),
                        Button(
                          textContent: lbl_sign_in,
                          onPressed: _phn.isNotEmpty && _pass.isNotEmpty
                              ? _submit
                              : null,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          child: Center(
                              child: Text(lbl_forgot_password,
                                  style: primaryTextStyle(
                                      color: colorPrimary, size: 16))),
                          onTap: () {},
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              lbl_newUser,
                              style: boldTextStyle(
                                  size: 18, color: textSecondaryColor),
                            ),
                            GestureDetector(
                              child: Center(
                                  child: Text(lbl_sign_up,
                                      style: primaryTextStyle(
                                          color: colorPrimary, size: 16))),
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
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
      ),
    );
  }
}
