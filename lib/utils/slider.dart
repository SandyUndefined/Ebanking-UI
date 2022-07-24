import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/silderWidget.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class T5Category {
  var name = "";
  Color? color;

  var icon = "";
}

class T5Slider {
  var image = "";
  var balance = "";
  var accountNo = "";
}

class T5Bill {
  var name;
  var day;
  var date;
  var isPaid = false;
  late var icon;
  var amount;
  var wallet = "Mastercard";
}

class T5Contact {
  late var img;

  var name;

  var isOnline = false;
  var subject;

  var contactno;
}

class T5SliderWidget extends StatelessWidget {
  List<T5Slider>? mSliderList;

  T5SliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final Size cardSize = Size(width, width / 1.8);
    return T5CarouselSlider(
      viewportFraction: 0.9,
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList!.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: cardSize.height,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(
                        BuildContext, String)?,
                    imageUrl: slider.image,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: cardSize.height,
                  ),
                  Padding(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text(
                            t5_avl_balance,
                            textColor: t5White,
                            fontSize: textSizeMedium,
                          ),
                          text(slider.balance,
                              textColor: t5White,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold)
                        ],
                      ),
                      padding: EdgeInsets.all(14)),
                  Container(
                    padding: EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text(
                                t5_account_number,
                                textColor: t5White,
                                fontSize: textSizeMedium,
                              ),
                              text(slider.accountNo,
                                  textColor: t5White, fontSize: textSizeNormal)
                            ],
                          ),
                        ),
                        text("VISA",
                            textColor: t5White,
                            fontSize: textSizeLarge,
                            fontFamily: fontBold)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
