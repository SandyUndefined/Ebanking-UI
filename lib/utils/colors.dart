import 'package:flutter/material.dart';

const colorPrimary = Color(0XFF5959fc);
const colorPrimaryDark = Color(0XFF7900F5);
const colorPrimaryLight = Color(0XFFF2ECFD);
const colorAccent = Color(0XFF7e05fa);
const textColorPrimary = Color(0XFF212121);
const textColorSecondary = Color(0XFF747474);
const app_background = Color(0XFFf8f8f8);
const iconColorSecondary = Color(0xFFA8ABAD);
const appSecondaryBackgroundColor = Color(0xff343434);
const view_color = Color(0XFFDADADA);
const white = Color(0XFFFFFFFF);
const icon_color = Color(0XFF747474);
const blue = Color(0XFF1C38D3);
const orange = Color(0XFFFF5722);
const background_bottom_navigation = Color(0XFFE9E7FE);
const background_selected = Color(0XFFF3EDFE);
const green = Color(0XFF5CD551);
const red = Color(0XFFFD4D4B);
const card_background = Color(0XFFFaFaFa);
const bg_bottom_sheet = Color(0XFFE8E6FD);
const instagram_pink = Color(0XFFCC2F97);
const linkedin_pink = Color(0XFF0c78b6);
var lightStatusBar = materialColor(0XFFEAEAF9);
var White = materialColor(0XFFFFFFFF);
var TextColorPrimary = materialColor(0XFF212121);
const shadow_color = Color(0XFFECECEC);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);
