import 'package:apes/screens/mobile_recharge.dart';
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
  List<ModelCategory>? mAnyList;
  String? titleName;
  var isScrollable = false;
  List? operatorList;

  T5GridListing(
      this.mAnyList, this.isScrollable, this.titleName, this.operatorList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: mAnyList!.length > 3 ? 6 : 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print(index);
              switch (index) {
                case 0:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobileRecharge(operatorList)));
                  break;
                case 5:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => More(
                                mAnyList,
                                titleName,
                              )));
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
                        bgColor: mAnyList![index].color, radius: 10),
                    child: Image.asset(
                      mAnyList![index].image,
                      color: t5White,
                    ),
                  ),
                  text(mAnyList![index].name,
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
