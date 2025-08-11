import 'package:rakaan/core/framework/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomTabBarItem extends StatelessWidget {
  const CustomTabBarItem({super.key, required this.title, this.onTab, required this.isSelected});

  final String title;
  final void Function()? onTab;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparentColor,
      hoverColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      onTap: onTab,
      child: Column(
        children: [
          Text(title,
              style: AppTextStyles.textStyle14.copyWith(
                  fontWeight: FontWeight.w500, color: isSelected ? AppColors.secondaryColor : AppColors.graySemiBoldColor)),
          heightSpace(8.h),
          Divider(color: isSelected ? AppColors.secondaryColor : AppColors.transparentColor,height: 0,)
        ],
      ),
    );
  }
}
