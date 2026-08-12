import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

Widget header(String text) {
  return Text(text,style: AppTextStyle.header6.copyWith(color: ColorManager.black,fontWeight: FontWeight.w600),);
}