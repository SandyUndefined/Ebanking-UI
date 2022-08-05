import 'package:apes/screens/homepage.dart';
import 'package:apes/screens/passbook.dart';
import 'package:apes/screens/profile.dart';
import 'package:apes/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

List<IconData> navbarIcons = [
  Icons.home,
  Icons.book_rounded,
  Icons.wallet_rounded,
  Icons.account_circle
];
List widgets = <Widget>[
  const HomePage(),
  const PassBook(),
  const Wallet(),
  const Profile()
];

List<String> bottomNavigationName = ['Home', 'Passbook', 'Wallet', 'Profile'];

List<Color> color = [Colors.blue, Colors.orange, Colors.red, Colors.green];

List<Color> colorShade = [
  Colors.blue.shade100,
  Colors.orange.shade100,
  Colors.red.shade100,
  Colors.green.shade100
];

int selectedIndex = 0;

customBottomNavBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12, top: 8),
    height: 70,
    decoration:
        boxDecorationDefault(borderRadius: radius(0), color: context.cardColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: navbarIcons.map(
        (e) {
          int i = navbarIcons.indexOf(e);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(8),
            height: 45,
            decoration: BoxDecoration(
              color: i == selectedIndex ? colorShade[i] : context.cardColor,
              borderRadius: radius(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  e,
                  size: 30,
                  color: i == selectedIndex ? color[i] : Colors.blueGrey[300],
                ).onTap(
                  () {
                    selectedIndex = i;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widgets[selectedIndex]));
                  },
                  splashColor: context.cardColor,
                ),
                Text(bottomNavigationName[i],
                        style: boldTextStyle(color: color[i]))
                    .paddingSymmetric(horizontal: 4)
                    .visible(i == selectedIndex),
              ],
            ),
          );
        },
      ).toList(),
    ),
  );
}
