import 'package:apes/model/auth.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/constant.dart';
import 'package:apes/utils/custom_bottom_nav_bar.dart';
import 'package:apes/utils/custom_drawer.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class PassBook extends StatefulWidget {
  const PassBook({Key? key}) : super(key: key);

  @override
  State<PassBook> createState() => _PassBookState();
}

class _PassBookState extends State<PassBook> {
  var currentIndexPage = 0;
  String name = "";
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var data = await Auth().getData();
    // print(data);
    // if (data['response_code'] == 401) {
    //   prefs.remove('authKey');
    //   prefs.remove('sessionKey');
    //   prefs.remove('name');
    //   Navigator.popAndPushNamed(context, '/login');
    // }
    setState(() {
      print(prefs.getString('name'));
      name = prefs.getString('name')!;
      // isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: t5DarkNavy,
        key: _scaffoldKey,
        drawer:
            // isLoading
            //     ? null
            //     :
            customDrawer(context, name.capitalizeFirstLetter()),
        bottomNavigationBar:
            // isLoading ? null :
            customBottomNavBar(context),
        body:
            // isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     :
            SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                margin: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: const Image(image: AssetImage(hamburger)),
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                        const SizedBox(width: 16),
                        text("PassBook",
                            textColor: t5White,
                            fontSize: textSizeNormal,
                            fontFamily: fontMedium)
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: text("PassBook",
                    textColor: t5White,
                    fontSize: textSizeLarge,
                    fontFamily: fontMedium),
              )
            ],
          ),
        ),
        // bottomNavigationBar: T5BottomBar(),
      ),
    );
  }
}
