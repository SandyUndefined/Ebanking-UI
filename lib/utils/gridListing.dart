import 'package:apes/model/user.dart';
import 'package:apes/screens/aadharwithdrawl.dart';
import 'package:apes/screens/broadband.dart';
import 'package:apes/screens/cabel.dart';
import 'package:apes/screens/dth.dart';
import 'package:apes/screens/electric.dart';
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
class T5GridListing extends StatefulWidget {
  List<ModelCategory>? mAnyList;
  String? titleName;
  var isScrollable = false;
  var pos;

  T5GridListing(this.mAnyList, this.isScrollable, this.titleName, this.pos);

  @override
  State<T5GridListing> createState() => _T5GridListingState();
}

class _T5GridListingState extends State<T5GridListing> {
  List prepaidList = [];
  List dthList = [];
  List cabelList = [];
  List electricList = [];
  List broadbandList = [];
  String? onBoardData;

  @override
  void initState() {
    super.initState();
    loadList();
  }

  loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var operatorList = await UserData().getPrepaid();
    var dthsList = await UserData().getDTH();
    var cabelTV = await UserData().getCabel();
    var electricity = await UserData().getElectric();
    var broadband = await UserData().getBroadband();
    var onBoard = prefs.getString("Onboard");
    setState(() {
      prepaidList = operatorList;
      dthList = dthsList;
      cabelList = cabelTV;
      electricList = electricity;
      broadbandList = broadband;
      onBoardData = onBoard!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: widget.isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: widget.mAnyList!.length > 3 ? widget.mAnyList!.length : 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print(index);
              if (widget.pos == 0) {
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => onBoardData == 0
                                ? DTHRecharge(dthList)
                                : AadharWithdrawl(onSubmit: (String value) {
                                    print(value);
                                  })));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DTHRecharge(dthList)));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cabel(cabelList)));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Electricity(electricList)));
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Broadband(broadbandList)));
                    break;
                  case 5:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => More(
                                  widget.mAnyList,
                                  widget.titleName,
                                )));
                    break;
                  default:
                }
              } else if (widget.pos == 1) {
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MobileRecharge(prepaidList)));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DTHRecharge(dthList)));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cabel(cabelList)));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Electricity(electricList)));
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Broadband(broadbandList)));
                    break;
                  case 5:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => More(
                                  widget.mAnyList,
                                  widget.titleName,
                                )));
                    break;
                  default:
                }
              } else if (widget.pos == 2) {}
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
                        bgColor: widget.mAnyList![index].color, radius: 10),
                    child: Image.asset(
                      widget.mAnyList![index].image,
                      color: t5White,
                    ),
                  ),
                  text(widget.mAnyList![index].name,
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
