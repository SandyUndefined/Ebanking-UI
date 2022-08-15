// import 'package:apes/model/user.dart';
// import 'package:apes/utils/colors.dart';
// import 'package:apes/utils/constant.dart';
// import 'package:apes/utils/custom_bottom_nav_bar.dart';
// import 'package:apes/utils/custom_drawer.dart';
// import 'package:apes/utils/custom_dropdown.dart';
// import 'package:apes/utils/customappbar.dart';
// import 'package:apes/utils/images.dart';
// import 'package:apes/utils/progress_bar.dart';
// import 'package:apes/utils/strings.dart';
// import 'package:apes/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DTHRecharge extends StatefulWidget {
//   const DTHRecharge({Key? key}) : super(key: key);

//   @override
//   State<DTHRecharge> createState() => _DTHRechargeState();
// }

// class _DTHRechargeState extends State<DTHRecharge> {
//   @override
//   Widget build(BuildContext context) {
//     changeStatusColor(t5DarkNavy);
//     var width = MediaQuery.of(context).size.width;
//     width = width - 50;
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       drawer: customDrawer(context, name.capitalizeFirstLetter()),
//       backgroundColor: t5DarkNavy,
//       key: _scaffoldKey,
//       appBar: CustomAppBar(state: _scaffoldKey, appBarName: "Mobile Recharge"),
//       body: Observer(
//         builder: (_) => Container(
//           height: MediaQuery.of(context).size.height,
//           // margin: const EdgeInsets.only(top: 20),
//           decoration: BoxDecoration(
//               color: context.scaffoldBackgroundColor,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(24), topRight: Radius.circular(24))),
//           child: Column(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(hint_phone, style: primaryTextStyle(size: 16)),
//                       EditTextField(
//                         onChanged: (text) {
//                           setState(() => _phn = text);
//                         },
//                         input: [FilteringTextInputFormatter.digitsOnly],
//                         autovalidateMode: _submitted
//                             ? AutovalidateMode.onUserInteraction
//                             : AutovalidateMode.disabled,
//                         isPassword: false,
//                         inputType: TextInputType.number,
//                         decoration: country_code,
//                         isSuffix: InkWell(
//                           onTap: () async {
//                             final PhoneContact contact =
//                                 await FlutterContactPicker.pickPhoneContact();
//                             if (contact != null) {
//                               setState(() {
//                                 _phn = contact.phoneNumber!.number
//                                     .removeAllWhiteSpace()
//                                     .replaceFirst('+91', '')
//                                     .toString();
//                                 print("this is $_phn");
//                               });
//                             }
//                           },
//                           child: const Icon(
//                             Icons.contacts,
//                             color: t5DarkNavy,
//                           ),
//                         ),
//                         validator: (text) {
//                           if (text == null || text.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                           if (text.length != 10) {
//                             return 'Enter a valid number';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       CustomDropdown<int>(
//                         onChange: (int value, int index) => setState(() {
//                           _operator = value.toString();
//                         }),
//                         dropdownButtonStyle: DropdownButtonStyle(
//                           width: MediaQuery.of(context).size.width,
//                           height: 40,
//                           elevation: 1,
//                           backgroundColor: Colors.white,
//                           primaryColor: Colors.black87,
//                         ),
//                         dropdownStyle: DropdownStyle(
//                           borderRadius: BorderRadius.circular(8),
//                           elevation: 6,
//                           padding: const EdgeInsets.all(5),
//                         ),
//                         items: widget.itemData!.map((item) {
//                           return DropdownItem(
//                             value: int.parse(item['LONGCODE']),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 item['PRODUCTNAME'],
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         child: const Text(
//                           select_operator,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       const SizedBox(height: 25),
//                       Text(hint_amount, style: primaryTextStyle(size: 16)),
//                       EditTextField(
//                         isSuffix: InkWell(
//                           onTap: () => showDialog(
//                               context: context,
//                               builder: (BuildContext context) =>
//                                   const PlanDialog()),
//                           child: Text(browse_plan,
//                               style: primaryTextStyle(
//                                   color: t5DarkNavy, size: 16)),
//                         ),
//                         input: [FilteringTextInputFormatter.digitsOnly],
//                         autovalidateMode: _submitted
//                             ? AutovalidateMode.onUserInteraction
//                             : AutovalidateMode.disabled,
//                         isPassword: false,
//                         inputType: TextInputType.number,
//                         validator: (text) {
//                           if (text == null || text.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                           return null;
//                         },
//                         onChanged: (text) => setState(() => _amount = text),
//                       ),
//                       const SizedBox(height: 25),
//                       Button(
//                         textContent: lbl_recharge,
//                         onPressed: _phn.isNotEmpty &&
//                                 _amount.isNotEmpty &&
//                                 _operator.isNotEmpty
//                             ? _submit
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
