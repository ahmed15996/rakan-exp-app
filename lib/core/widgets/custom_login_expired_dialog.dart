import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../util/routing/routes.dart';
import 'custom_button.dart';

class CustomLoginExpiredDialog extends StatelessWidget {
  const CustomLoginExpiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      backgroundColor: AppColors.whiteColor,
      content: SizedBox(
        width: context.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              heightSpace(10.h),
              SvgPicture.asset(
                AppAssets.unAuthenticated,
                width: 120.w,
                height: 110.h,
                fit: BoxFit.cover,
              ),
              heightSpace(24.h),
              Text(
                LocaleKeys.askForLoginExpired.tr(),
                style: AppTextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                ),
              ),
              heightSpace(6.h),
              Text(
                LocaleKeys.askForLoginExpiredDesc.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.graySemiBoldColor,
                ),
              ),
              heightSpace(32.h),
              CustomButton(
                text: LocaleKeys.login.tr(),
                height: 45.h,
                onPressed: () {
                  context.pushAndRemoveUntilWithNamed(
                    Routes.loginView,
                  );
                },
              ),
              heightSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
