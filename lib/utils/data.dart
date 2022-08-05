import 'package:apes/utils/colors.dart';
import 'package:apes/utils/images.dart';
import 'package:apes/utils/slider.dart';

List<T5Category> getCategoryItems() {
  List<T5Category> list = [];

  var category1 = T5Category();
  category1.name = "Aadhar Widthdrawl";
  category1.color = t5Cat1;
  category1.icon = t5_paperplane;
  list.add(category1);
  var category2 = T5Category();
  category2.name = "Balance Enquiry";
  category2.color = t5Cat2;
  category2.icon = t5_wallet;
  list.add(category2);
  var category3 = T5Category();
  category3.name = "Mini Statement";
  category3.color = t5Cat3;
  category3.icon = t5_coupon;
  list.add(category3);
  var category4 = T5Category();
  category4.name = "Aadhar Pay";
  category4.color = t5Cat4;
  category4.icon = t5_invoice;
  list.add(category4);

  var category5 = T5Category();
  category5.name = "Money Transfer";
  category5.color = t5Cat5;
  category5.icon = t5_dollar_exchange;
  list.add(category5);

  var category = T5Category();
  category.name = "More";
  category.color = t5Cat6;
  category.icon = t5_circle;
  list.add(category);
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
