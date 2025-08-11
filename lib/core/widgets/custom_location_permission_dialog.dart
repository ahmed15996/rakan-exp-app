import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/custom_location_helper.dart';
import 'custom_button.dart';

// import 'custom_button.dart';

class CustomLocationPermissionDialog extends StatelessWidget {
  final Function() onFinish;

  const CustomLocationPermissionDialog({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => onFinish(),
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: AppColors.whiteColor,
        content: SizedBox(
          width: context.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.allowLocationDetection.tr(),
                  style: AppTextStyles.textStyle18.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                heightSpace(18.h),
                Text(
                  LocaleKeys.allowLocationDescription.tr(),
                  style: AppTextStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(22.h),
                Text(
                  LocaleKeys.step1.tr(),
                  style: AppTextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(16.h),
                Text(
                  LocaleKeys.step2.tr(),
                  style: AppTextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(16.h),
                Text(
                  LocaleKeys.step3.tr(),
                  style: AppTextStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightSpace(25.h),
                CustomButton(
                  onPressed: () {
                    LocationHelper.openAppIfPermissionDenied(
                      onFinish: onFinish,
                    );
                  },
                  text: LocaleKeys.goToSettings.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
