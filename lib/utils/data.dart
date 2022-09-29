import 'package:apes/screens/mobile_recharge.dart';
import 'package:apes/utils/colors.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/slider.dart';

List<ModelCategory> getBankingItems() {
  List<ModelCategory> list = [];

  var category1 = ModelCategory();
  category1.name = "Aadhar Widthdrawl";
  category1.color = t5Cat1;
  category1.image = aadharWithdrawl;
  list.add(category1);
  var category2 = ModelCategory();
  category2.name = "Balance Enquiry";
  category2.color = t5Cat2;
  category2.image = balanceEnquiry;
  list.add(category2);

  var category3 = ModelCategory();
  category3.name = "Mini Statement";
  category3.color = t5Cat3;
  category3.image = miniStatement;
  list.add(category3);

  var category4 = ModelCategory();
  category4.name = "Aadhar Pay";
  category4.color = t5Cat4;
  category4.image = aadharWithdrawl;
  list.add(category4);

  var category5 = ModelCategory();
  category5.name = "DMT";
  category5.color = t5Cat5;
  category5.image = moneyTransfer;
  list.add(category5);

  // var category = ModelCategory();
  // category.name = "AEPS";
  // category.color = t5Cat6;
  // category.image = more;
  // list.add(category);

  // var category6 = ModelCategory();
  // category6.name = "Wallet Transfer";
  // category6.color = t5Cat3;
  // category6.image = walletTransfer;
  // list.add(category6);

  // var category7 = ModelCategory();
  // category7.name = "Micro ATM";
  // category7.color = t5Cat4;
  // category7.image = microATM;
  // list.add(category7);

  // var category8 = ModelCategory();
  // category8.name = "Settlement";
  // category8.color = t5Cat5;
  // category8.image = deal;
  // list.add(category8);

  return list;
}

List<ModelCategory> getRechargeItems() {
  List<ModelCategory> list = [];

  var category1 = ModelCategory();
  category1.name = "Mobile Recharge";
  category1.color = t5Cat1;
  category1.image = t5_paperplane;
  list.add(category1);
  var category2 = ModelCategory();
  category2.name = "DTH Recharge";
  category2.color = t5Cat2;
  category2.image = t5_wallet;
  list.add(category2);

  var category3 = ModelCategory();
  category3.name = "Cable TV Recharge";
  category3.color = t5Cat3;
  category3.image = t5_coupon;
  list.add(category3);

  var category4 = ModelCategory();
  category4.name = "Electric Bill";
  category4.color = t5Cat4;
  category4.image = t5_invoice;
  list.add(category4);

  var category5 = ModelCategory();
  category5.name = "Broadband Bill";
  category5.color = t5Cat5;
  category5.image = t5_dollar_exchange;
  list.add(category5);

  // var category = ModelCategory();
  // category.name = "More";
  // category.color = t5Cat6;
  // category.image = t5_circle;
  // list.add(category);

  // var category6 = ModelCategory();
  // category6.name = "Mini Statement";
  // category6.color = t5Cat3;
  // category6.image = t5_coupon;
  // list.add(category6);

  // var category7 = ModelCategory();
  // category7.name = "Aadhar Pay";
  // category7.color = t5Cat4;
  // category7.image = t5_invoice;
  // list.add(category7);

  // var category8 = ModelCategory();
  // category8.name = "Money Transfer";
  // category8.color = t5Cat5;
  // category8.image = t5_dollar_exchange;
  // list.add(category8);

  return list;
}

List<ModelCategory> getReportItems() {
  List<ModelCategory> list = [];

  var category1 = ModelCategory();
  category1.name = "All Report";
  category1.color = t5Cat1;
  category1.image = t5_paperplane;
  list.add(category1);
  var category2 = ModelCategory();
  category2.name = "AEPS Report";
  category2.color = t5Cat2;
  category2.image = t5_wallet;
  list.add(category2);

  var category3 = ModelCategory();
  category3.name = "Recharge Report";
  category3.color = t5Cat3;
  category3.image = t5_coupon;
  list.add(category3);

  return list;
}

List<T5Slider> getSliders() {
  List<T5Slider> list = [];
  T5Slider model1 = T5Slider();
  model1.balance = "\$150000";
  model1.accountNo = "145 250 230 120 150";
  model1.image = t5_bg_card_2;
  T5Slider model2 = T5Slider();
  model2.balance = "\$150000";
  model2.accountNo = "145 250 230 120 150";
  model2.image = t5_bg_card_1;
  T5Slider model3 = T5Slider();
  model3.balance = "\$150000";
  model3.accountNo = "145 250 230 120 150";
  model3.image = t5_bg_card_3;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}
