import 'dart:convert';

import 'package:apes/model/auth.dart';
import 'package:apes/model/user.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/data.dart';
import 'package:apes/utils/gridListing.dart';
import 'package:apes/utils/images.dart';
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
  List<T5Category>? mFavouriteList;
  List<T5Slider>? mSliderList;
  String main_bal = "";
  String aeps_bal = "";
  String id = "";
  String name = "";

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getCategoryItems();
    mSliderList = getSliders();
    printData();
  }

  printData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('name'));
      name = prefs.getString('name')!;
    });
    var response = await Auth().getData();
    print(prefs.getInt('id'));
    print(response.statusCode);
    print(response.body);
  }

  Future<void> _logout() async {
    var response = await Auth().logout();
    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.popAndPushNamed(context, '/login');
    }
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
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: t5DarkNavy,
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 70,
                margin: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(t5_profile_8),
                          radius: 25,
                        ),
                        const SizedBox(width: 16),
                        text(name.capitalizeFirstLetter(),
                            textColor: t5White,
                            fontSize: textSizeNormal,
                            fontFamily: fontMedium)
                      ],
                    ),
                    InkWell(
                      splashColor: White,
                      onTap: _logout,
                      child: text(logout,
                          textColor: t5White,
                          fontSize: textSizeMedium,
                          fontFamily: fontMedium),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
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
                      T5SliderWidget(mSliderList),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Main Balance: $main_bal",
                            style: boldTextStyle(size: 20),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "AEPS Balance: $aeps_bal",
                            style: boldTextStyle(size: 20),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: T5GridListing(mFavouriteList, false),
                        ),
                      )
                    ],
                  ),
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
