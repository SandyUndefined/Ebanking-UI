import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState>? state;
  String? appBarName;
  CustomAppBar({this.state, this.appBarName});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                child: const Image(image: AssetImage(hamburger)),
                onTap: () {
                  state!.currentState!.openDrawer();
                },
              ),
              const SizedBox(width: 16),
              text(appBarName,
                  textColor: t5White,
                  fontSize: textSizeLarge,
                  fontFamily: fontMedium)
            ],
          )
        ],
      ),
    );
  }
}
