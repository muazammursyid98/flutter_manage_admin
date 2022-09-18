import 'package:dext_expenditure_dashboard/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

checkConditionWidth(context) {
  double width = MediaQuery.of(context).size.width;
  if (width >= 1200) {
    return getProportionateScreenWidth(200);
  } else {
    switch (Device.screenType) {
      case ScreenType.mobile:
        return double.infinity;
      default:
        return getProportionateScreenWidth(200);
    }
  }
}
