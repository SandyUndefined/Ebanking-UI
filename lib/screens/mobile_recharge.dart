import 'package:apes/model/user.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/custom_bottom_nav_bar.dart';
import 'package:apes/utils/custom_drawer.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({Key? key}) : super(key: key);

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  String name = "";
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String _phn = '';
  List prepaidList = [];

  String _amount = '';
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var data = await UserData().getPrepaid();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('name'));
      name = prefs.getString('name')!;
      prepaidList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: customDrawer(context, name.capitalizeFirstLetter()),
      backgroundColor: t5LayoutBackgroundWhite,
      key: _scaffoldKey,
      body: Observer(
        builder: (_) => SingleChildScrollView(
          child: Container(
            // color: t5LayoutBackgroundWhite,
            child: Column(
              children: [
                SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 50,
                        margin: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child:
                                      const Image(image: AssetImage(hamburger)),
                                  onTap: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                ),
                                const SizedBox(width: 16),
                                text("Mobile Recharge",
                                    textColor: t5White,
                                    fontSize: textSizeNormal,
                                    fontFamily: fontMedium)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
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
                          isSecure: false,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            return null;
                          },
                          onChanged: (text) => setState(() => _amount = text),
                        ),
                        const SizedBox(height: 18),
                        Button(
                          textContent: lbl_sign_in,
                          onPressed: _phn.isNotEmpty && _amount.isNotEmpty
                              ? null
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: T5BottomBar(),
        ),
      ),
    );
  }
}
