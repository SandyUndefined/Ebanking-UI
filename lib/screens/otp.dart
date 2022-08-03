import 'dart:convert';

import 'package:apes/model/auth.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/progress_bar.dart';
import 'package:apes/utils/snackbar.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String _otp = '';

  Future<void> _submit() async {
    progressBar(context);
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_otp);
    }
    var data = await Auth().verifyLoginOtp(_otp);
    print(data);
    if (data['satuts'] == 'err') {
      Navigator.pop(context);
      print(data['result']);
      floatingSnackBar(context, "(data['result'])");
    } else if (data['status'] == 'success') {
      Auth().saveLoginKey(data['Login_Key']);
      Auth().saveSessionId(data['SESSION_ID']);
      Auth().saveName(data['Name']);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, '/home');
    } else if (data['status'] == 'err') {
      Navigator.pop(context);
      floatingSnackBar(context, "(data['result'])");
      print("Opps there is a Mistake");
    } else if (data['status'] == 'wrong_otp') {
      Navigator.pop(context);
      floatingSnackBar(context, "(data['result'])");
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(
                          BuildContext, String)?,
                      imageUrl: verification,
                      width: width / 2.5,
                      height: width / 2.5),
                  const SizedBox(height: 30),
                  Text(verify_otp,
                      style: boldTextStyle(size: 22, color: textPrimaryColor)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 16),
                    child: Text(otp_note,
                        style: primaryTextStyle(
                            size: 18, color: textColorSecondary),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: colorPrimaryLight,
                        boxShadow: const [BoxShadow(color: Colors.transparent)],
                        border: Border.all(color: colorPrimary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          PinEntryTextField(
                            fields: 6,
                            fontSize: 20,
                            onSubmit: (value) => setState(() => _otp = value),
                          ),
                          const SizedBox(height: 24),
                          Button(
                            textContent: opt_confirm,
                            onPressed: _otp.isNotEmpty ? _submit : null,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toasty(context, resend);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      child: Text(resend,
                          style:
                              primaryTextStyle(color: colorPrimary, size: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
