import 'package:apes/screens/more.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/slider.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class T5GridListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5GridListing(this.mFavouriteList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 5:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => More()));
                  break;
                default:
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(
                  radius: 10,
                  showShadow: true,
                  bgColor: context.scaffoldBackgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: const EdgeInsets.only(bottom: 4, top: 8),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(
                        bgColor: mFavouriteList![index].color, radius: 10),
                    child: SvgPicture.asset(
                      mFavouriteList![index].icon,
                      color: t5White,
                    ),
                  ),
                  text(mFavouriteList![index].name,
                      textColor: textSecondaryColor,
                      fontSize: textSizeSmall,
                      maxLine: 2,
                      isCentered: true)
                ],
              ),
            ),
          );
        });
  }
}
