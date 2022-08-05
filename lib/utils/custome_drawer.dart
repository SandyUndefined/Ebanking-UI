import 'package:apes/model/auth.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/progress_bar.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> logout(BuildContext context) async {
  progressBar(context);
  var data = await Auth().logout();
  print(data);
  if (data == 200) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('authKey');
    localStorage.remove('sessionKey');
    localStorage.remove('name');
    Navigator.popAndPushNamed(context, '/login');
  }
}

customeDrawer(BuildContext context, name) {
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40, top: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.orange),
                    image: const DecorationImage(image: AssetImage(profile)),
                  ),
                ),
                const SizedBox(height: 5.0),
                text(name,
                    textColor: textColorPrimary,
                    fontSize: textSizeNormal,
                    fontFamily: fontMedium),
                30.height,
                itemList(const Icon(Icons.home, color: icon_color), "Home"),
                const Divider(),
                15.height,
                itemList(const Icon(Icons.person_pin, color: icon_color),
                    "My profile"),
                const Divider(),
                15.height,
                itemList(
                    const Icon(Icons.message, color: icon_color), "Messages"),
                const Divider(),
                15.height,
                itemList(const Icon(Icons.notifications, color: icon_color),
                    "Notifications"),
                const Divider(),
                15.height,
                itemList(
                    const Icon(Icons.settings, color: icon_color), "Settings"),
                const Divider(),
                15.height,
                itemList(
                    const Icon(Icons.email, color: icon_color), "Contact us"),
                const Divider(),
                15.height,
                itemList(
                    const Icon(Icons.info_outline, color: icon_color), "Help"),
                const Divider(),
                15.height,
                itemList(const Icon(Icons.logout_rounded, color: icon_color),
                        "Logout")
                    .onTap(() {
                  logout(context);
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget itemList(Widget icon, String title) {
  return Row(
    children: [
      icon,
      10.width,
      Text(title, style: const TextStyle(color: textColorPrimary)),
    ],
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
