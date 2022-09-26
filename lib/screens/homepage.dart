import 'dart:convert';

import 'package:apes/model/auth.dart';
import 'package:apes/model/user.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/custom_bottom_nav_bar.dart';
import 'package:apes/utils/custom_drawer.dart';
import 'package:apes/utils/customappbar.dart';
import 'package:apes/utils/data.dart';
import 'package:apes/utils/gridListing.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/progress_bar.dart';
import 'package:apes/utils/slider.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

import 'package:nb_utils/nb_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 0;
  List<ModelCategory>? bankingList;
  List<ModelCategory>? rechargeList;
  List<ModelCategory>? reportList;
  List<T5Slider>? mSliderList;
  String main_bal = "";
  String aeps_bal = "";
  String name = "";
  bool isLoading = true;
  List<T5Slider> getBalSliders() {
    print("this is main $main_bal");
    List<T5Slider> list = [];

    T5Slider model1 = T5Slider();
    model1.name = "Main Balance";
    model1.balance = main_bal;
    model1.image = t5_bg_card_2;
    model1.accountNo = name.capitalizeFirstLetter();

    T5Slider model2 = T5Slider();
    model2.name = "AEPS Balance";
    model2.balance = aeps_bal;
    model2.image = t5_bg_card_1;
    model2.accountNo = name.capitalizeFirstLetter();
    list.add(model1);
    list.add(model2);
    return list;
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await Auth().getData();
    print(data);
    if (data['response_code'] == 401) {
      prefs.remove('authKey');
      prefs.remove('sessionKey');
      prefs.remove('name');
      Navigator.popAndPushNamed(context, '/login');
    }
    setState(() {
      main_bal = data['MAIN'];
      aeps_bal = data['AEPS'];
      print(prefs.getString('name'));
      name = prefs.getString('name')!;
      bankingList = getBankingItems();
      rechargeList = getRechargeItems();
      reportList = getReportItems();
      mSliderList = getBalSliders();
      isLoading = false;
    });
  }

  void changeSldier(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Observer(
      builder: (_) => Scaffold(
        key: _scaffoldKey,
        drawer: customDrawer(context, name),
        appBar: CustomAppBar(state: _scaffoldKey, appBarName: "Bharat AEPS"),
        backgroundColor: t5DarkNavy,
        bottomNavigationBar: isLoading ? null : customBottomNavBar(context),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 28),
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height - 100,
                      decoration: BoxDecoration(
                          color: context.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Column(
                        children: <Widget>[
                          T5SliderWidget(mSliderList, main_bal, aeps_bal),
                          const SizedBox(height: 20),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                text("Banking & Services",
                                    textColor: textColorPrimary,
                                    fontSize: textSizeNormal,
                                    fontFamily: fontMedium),
                                SizedBox(
                                  height: height * .35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: T5GridListing(bankingList, false,
                                        "Banking & Services", 0),
                                  ),
                                ),
                                text("Recharge & Bill Payments",
                                    textColor: textColorPrimary,
                                    fontSize: textSizeNormal,
                                    fontFamily: fontMedium),
                                SizedBox(
                                  height: height * .35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: T5GridListing(rechargeList, false,
                                        "Recharge & Bill Payments", 1),
                                  ),
                                ),
                                text("Reports",
                                    textColor: textColorPrimary,
                                    fontSize: textSizeNormal,
                                    fontFamily: fontMedium),
                                SizedBox(
                                  height: height * .35,
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: T5GridListing(
                                        reportList, false, "Reports", 2),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        // bottomNavigationBar: T5BottomBar(),
      ),
    );
  }
}
