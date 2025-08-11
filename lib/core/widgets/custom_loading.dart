import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../framework/spaces.dart';

class CustomLoading extends StatelessWidget {
  final bool? isButton, isLogo;
  final double? heightLoading, widthLoading, strokeWidth;
  final Color? color;

  const CustomLoading(
      {super.key,
      this.isButton = false,
      this.isLogo = true,
      this.heightLoading,
      this.widthLoading,
      this.strokeWidth,
      this.color});

  @override
  Widget build(BuildContext context) {
    return isButton == true
        ? SizedBox(
            height: heightLoading ?? 15.h,
            width: widthLoading ?? 15.w,
            child: CircularProgressIndicator(
              color: color ?? AppColors.whiteColor,
              strokeWidth: strokeWidth ?? 3.w,
            ),
          )
        : isLogo == true
            ? SizedBox(
                width: context.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssets.authLogo,
                      height: context.height * 0.05,
                      width: context.width * 0.32,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.authLogo,
                              height: context.height * 0.05,
                              width: context.width * 0.32,
                            ),
                            heightSpace(15.h),
                            Text(
                              LocaleKeys.loading.tr(),
                              style: AppTextStyles.textStyle16.copyWith(
                                color: AppColors.blackTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                width: context.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                     AppAssets.authLogo,
                      height: context.height * 0.05,
                      width: context.width * 0.32,
                    ),
                    heightSpace(15.h),
                    Text(
                      LocaleKeys.loading.tr(),
                      style: AppTextStyles.textStyle16.copyWith(
                        color: AppColors.blackTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
  }
}
