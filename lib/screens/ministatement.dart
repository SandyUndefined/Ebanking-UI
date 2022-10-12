import 'package:apes/model/user.dart';
import 'package:apes/utils/biometric_device.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/custom_drawer.dart';
import 'package:apes/utils/custom_dropdown.dart';
import 'package:apes/utils/customappbar.dart';
import 'package:apes/utils/progress_bar.dart';
import 'package:apes/utils/strings.dart';
import 'package:apes/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiniStatement extends StatefulWidget {
  const MiniStatement({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  State<MiniStatement> createState() => _MiniStatementState();
}

class _MiniStatementState extends State<MiniStatement> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String _aadharNumber = "";
  String _phn = '';
  String _bank = '';

  bool _submitted = false;
  bool isLoading = true;

  late List<dynamic> bankList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var banks = await UserData().getBank();
    setState(() {
      print(prefs.getString('name'));
      name = prefs.getString('name')!;
      bankList = banks;
      print("$bankList ");
      isLoading = false;
    });
  }

  Future<void> _submit() async {
    progressBar(context);
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_aadharNumber);
      widget.onSubmit(_phn);
      widget.onSubmit(_bank);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: customDrawer(context, name.capitalizeFirstLetter()),
      backgroundColor: t5DarkNavy,
      key: _scaffoldKey,
      appBar: CustomAppBar(
          state: _scaffoldKey, appBarName: "Mini Statement", isback: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Observer(
              builder: (_) => SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  // margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(aadhar_number,
                                  style: primaryTextStyle(size: 16)),
                              EditTextField(
                                input: [FilteringTextInputFormatter.digitsOnly],
                                autovalidateMode: _submitted
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                isPassword: false,
                                inputType: TextInputType.number,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Can\'t be empty';
                                  }
                                  if (text.length != 12) {
                                    return 'Enter a valid Aadhar Number';
                                  }
                                  return null;
                                },
                                onChanged: (text) =>
                                    setState(() => _aadharNumber = text),
                              ),
                              const SizedBox(height: 25),
                              Text(hint_phone,
                                  style: primaryTextStyle(size: 16)),
                              EditTextField(
                                onChanged: (text) {
                                  setState(() => _phn = text);
                                },
                                input: [FilteringTextInputFormatter.digitsOnly],
                                autovalidateMode: _submitted
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                isPassword: false,
                                inputType: TextInputType.number,
                                decoration: country_code,
                                isSuffix: InkWell(
                                  onTap: () async {
                                    final PhoneContact contact =
                                        await FlutterContactPicker
                                            .pickPhoneContact();
                                    if (contact != null) {
                                      setState(() {
                                        _phn = contact.phoneNumber!.number
                                            .removeAllWhiteSpace()
                                            .replaceFirst('+91', '')
                                            .toString();
                                        print("this is $_phn");
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.contacts,
                                    color: t5DarkNavy,
                                  ),
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Can\'t be empty';
                                  }
                                  if (text.length != 10) {
                                    return 'Enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              Text(select_bank,
                                  style: primaryTextStyle(size: 16)),
                              const SizedBox(height: 25),
                              CustomDropdown<int>(
                                onChange: (int value, int index) =>
                                    setState(() {
                                  _bank = value.toString();
                                }),
                                dropdownButtonStyle: DropdownButtonStyle(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  elevation: 1,
                                  backgroundColor: Colors.white,
                                  primaryColor: Colors.black87,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(8),
                                  elevation: 6,
                                  padding: const EdgeInsets.all(5),
                                ),
                                items: bankList.map((item) {
                                  return DropdownItem(
                                    value: int.parse(item['BANK_ID']),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item['BANK_NAME'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                child: const Text(
                                  select_bank,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Button(
                                textContent: scan,
                                onPressed: _aadharNumber.isNotEmpty &&
                                        _phn.isNotEmpty &&
                                        _bank.isNotEmpty
                                    ? _submit
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
