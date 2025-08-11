import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_button.dart';

import '../cubit/select_language_cubit.dart';

class SelectLanguageView extends StatelessWidget {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo, width: 100.r, height: 100.r).withPadding(bottom: 16.h),
              Text(
                "من فضلك قم باختيار لغة التطبيق",
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyle18.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ).withPadding(bottom: 8.h),
              Text(
                "Please Select The App Language",
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyle18.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ).withPadding(bottom: 80.h),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    text: "العربية",
                    onPressed: () {
                      context.read<SelectLanguageCubit>().saveChanges(context, 0);
                    },
                  )),
                  SizedBox(width: 24.w),
                  Expanded(
                      child: CustomButton(
                    text: "English",
                    onPressed: () {
                      context.read<SelectLanguageCubit>().saveChanges(context, 1);
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
 onTap: () {

                },



 */
