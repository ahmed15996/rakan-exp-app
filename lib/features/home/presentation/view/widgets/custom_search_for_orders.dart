import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

class CustomSearchForOrders extends StatelessWidget {
  const CustomSearchForOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(AppAssets.map, width: 32.r, height: 32.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.searchingForOrders.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackColor))
                  .withPadding(bottom: 6.h),
              Text(LocaleKeys.blueAreaNote.tr(),
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
            ],
          ).withPadding(start: 12.w),
        )
      ],
    ).withPadding(top: 40.h, bottom: 16.h);
  }
}
