import 'package:rakaan/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget onTap({required void Function() function}) {
    return GestureDetector(
      onTap: function,
      child: this,
    );
  }

  Widget onTapShadow({required BorderRadius borderRadius, required void Function() function}) {
    return InkWell(
      onTap: function,
      borderRadius: borderRadius,
      splashColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      child: this,
    );
  }
}
