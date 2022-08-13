import 'package:apes/utils/colors.dart';
import 'package:apes/utils/data.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/slider.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class More extends StatefulWidget {
  List<ModelCategory>? mAnyList;
  String? titleName;
  More(this.mAnyList, this.titleName);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: t5DarkNavy,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(back),
            ),
          ),
          title: Text(
            widget.titleName!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.mAnyList!.length,
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              if (index == 5) {
                print(index);
                null;
              } else {
                return DataList(widget.mAnyList![index], index);
              }
              print("sadad");
              return Container();
            }),
      ),
    );
  }
}

class DataList extends StatelessWidget {
  late ModelCategory model;

  DataList(ModelCategory model, int pos) {
    this.model = model;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: boxDecoration(
          radius: 10,
          showShadow: true,
          bgColor: context.scaffoldBackgroundColor),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Image.asset(
            model.image,
            height: 40,
            width: 40,
          ),
          16.width,
          Text(
            model.name,
            style: boldTextStyle(color: textPrimaryColor),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
