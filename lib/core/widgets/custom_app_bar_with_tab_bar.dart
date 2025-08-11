import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../framework/spaces.dart';
import 'custom_tab_bar.dart';

class CustomAppBarWithTabBar extends StatelessWidget {
  const CustomAppBarWithTabBar(
      {super.key,
      required this.tabController,
      required this.textList,
      required this.title,
      this.withBack = true});

  final TabController tabController;
  final List<String> textList;
  final String title;
  final bool withBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(15.r),
          bottomEnd: Radius.circular(15.r),
        ),

        border: const BorderDirectional(
          bottom: BorderSide(
            color: AppColors.whiteLightColor,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 15.w, end: 15.w, top: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (withBack) ...[
                    SvgPicture.asset(
                      context.locale.languageCode == "ar"
                          ? "AppAssets.arrowBrown"
                          : "AppAssets.arrowBrownEn",
                      height: 20.h,
                      width: 20.w,
                    ).onTap(
                      function: () {
                        context.pop();
                      },
                    ),
                    widthSpace(10.w),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.textStyle16.copyWith(color: AppColors.blackTextColor),
                    ),
                  ),
                ],
              ),
              heightSpace(14.h),
              CustomTapBar(
                tabController: tabController,
                textList: textList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
