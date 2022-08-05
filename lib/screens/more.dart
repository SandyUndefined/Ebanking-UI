import 'package:apes/utils/images.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(back),
            ),
          ),
          title: const Text(
            "Banking & Saving",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.normal,
              color: textPrimaryColor,
            ),
          ),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: dataList.length,
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              return DataList(dataList[index], index);
            }),
      ),
    );
  }
}

class DataList extends StatelessWidget {
  late DataModel model;

  DataList(DataModel model, int pos) {
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
            model.images,
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

class DataModel {
  var images;
  var name;

  DataModel({
    this.images,
    this.name,
  });
}

List<DataModel> dataList = [
  DataModel(
    images: 'images/airplane.png',
    name: 'Travels',
  ),
  DataModel(
    images: 'images/book.png',
    name: 'Education',
  ),
  DataModel(
    images: 'images/computer.png',
    name: 'Management',
  ),
  DataModel(
    images: 'images/finance.png',
    name: 'Finance',
  ),
  DataModel(
    images: 'images/food.png',
    name: 'Food',
  ),
  DataModel(
    images: 'images/graphic.png',
    name: 'Business',
  ),
  DataModel(
    images: 'images/healthy.png',
    name: 'Yoga & Gym',
  ),
  DataModel(
    images: 'images/heart.png',
    name: 'Health',
  ),
  DataModel(
    images: 'images/airplane.png',
    name: 'Travel',
  ),
  DataModel(
    images: 'images/book.png',
    name: 'Education',
  ),
  DataModel(
    images: 'images/computer.png',
    name: 'Management',
  ),
  DataModel(
    images: 'images/finance.png',
    name: 'Finance',
  ),
  DataModel(
    images: 'images/food.png',
    name: 'Food',
  ),
  DataModel(
    images: 'images/airplane.png',
    name: 'Travel',
  ),
  DataModel(
    images: 'images/book.png',
    name: 'Education',
  ),
  DataModel(
    images: 'images/computer.png',
    name: 'Management',
  ),
  DataModel(
    images: 'images/finance.png',
    name: 'Finance',
  ),
  DataModel(
    images: 'images/food.png',
    name: 'Food',
  ),
  DataModel(
    images: 'images/graphic.png',
    name: 'Business',
  ),
  DataModel(
    images: 'images/healthy.png',
    name: 'Yoga & Gym',
  ),
  DataModel(
    images: 'images/heart.png',
    name: 'Health',
  ),
  DataModel(
    images: 'images/airplane.png',
    name: 'Travel',
  ),
  DataModel(
    images: 'images/book.png',
    name: 'Education',
  ),
  DataModel(
    images: 'images/computer.png',
    name: 'Management',
  ),
  DataModel(
    images: 'images/finance.png',
    name: 'Finance',
  ),
  DataModel(
    images: 'images/food.png',
    name: 'Food',
  ),
];
