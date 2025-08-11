import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates { success, error, warning }

Color? toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = AppColors.greenColor;
      break;
    case ToastStates.error:
      color = AppColors.redColor;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state),
      textColor: AppColors.whiteColor,
      fontAsset: "assets/fonts/Cairo-Medium.ttf",
      fontSize: AppFonts.t13,
    );
