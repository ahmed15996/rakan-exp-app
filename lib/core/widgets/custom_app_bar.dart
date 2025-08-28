import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.widget, this.showContact = true});

  final String title;
  final Widget? widget;
  final bool showContact;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Directionality(
            textDirection: context.locale.languageCode=='ar'?TextDirection.ltr:TextDirection.rtl,
            child: SvgPicture.asset(
              AppAssets.arrow,
              width: 24.r,

              height: 24.r,
              matchTextDirection: true,
              colorFilter: ColorFilter.mode(AppColors.blackTextColor, BlendMode.srcIn),
            ).onTapShadow(
                borderRadius: BorderRadius.circular(8.r),
                function: () {
                  context.pop();
                }),
          ),
          Text(title, style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
              .withPadding(horizontal: 16.w),
          if (widget != null)
            widget!
          else
            SvgPicture.asset(
              AppAssets.arrow,
              width: 24.r,
              height: 24.r,
              colorFilter: ColorFilter.mode(AppColors.transparentColor, BlendMode.srcIn),
            )
        ],
      ).withPadding(vertical: 20.h, horizontal: 16.w),
    );
  }
}
