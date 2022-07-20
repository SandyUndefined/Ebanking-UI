import 'package:apes/utils/colors.dart';
import 'package:apes/utils/dots_indicator/dots_indicator.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:apes/utils/widgets.dart';

import '../../../main.dart';

class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int currentIndexPage = 0;
  int? pageLength;

  var titles = [
    "All important tips",
    "Meditation is usefull for health",
    "Jogging is good for health"
  ];

  var subTitles = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text"
  ];

  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);

    return Scaffold(
      body: Observer(
        builder: (_) => Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: const <Widget>[
                  Slider(textContent: slider_1),
                  Slider(textContent: slider_2),
                  Slider(textContent: slider_3),
                ],
                onPageChanged: (value) {
                  setState(() => currentIndexPage = value);
                },
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: 50,
              top: MediaQuery.of(context).size.height * 0.58,
              child: Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: currentIndexPage,
                  decorator: const DotsDecorator(
                      color: view_color, activeColor: colorPrimary),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(titles[currentIndexPage],
                        style:
                            boldTextStyle(size: 20, color: textPrimaryColor)),
                    const SizedBox(height: 10),
                    Center(
                        child: Text(subTitles[currentIndexPage],
                            style: primaryTextStyle(
                                size: 18, color: textColorSecondary),
                            textAlign: TextAlign.center)),
                    //SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Button(
                  textContent: lbl_get_started,
                  onPressed: () {
                    changeStatusColor(White);
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  final String textContent;

  const Slider({Key? key, required this.textContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SizedBox(
        child: Stack(
          children: <Widget>[
            Image.asset(t2_walk_bg,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height) / 1.7),
            SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height) / 1.7,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(
                      BuildContext, String)?,
                  imageUrl: textContent,
                  width: 300,
                  height: (MediaQuery.of(context).size.height) / 2.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
