import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/widgets/custom_circle_icon.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';
import 'custom_part_search_bar_widget.dart';

class CustomSearchAppBar extends StatelessWidget {
  final String title;
  final void Function()? playSearch , stopSearch , onTapFilter , onTapBack;
  final TextEditingController? ctrl;
  final bool withBack;
  final bool isShowFilterIcon;

  const CustomSearchAppBar({
    super.key,
    this.title = "",
    this.ctrl,
    this.playSearch,
    this.stopSearch,
    this.onTapFilter,
    this.onTapBack,
    this.withBack = true,
    this.isShowFilterIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 15.w,
        end: 15.w,
        top: 25.h,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteLightColor,
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
        child: Row(
          children: [
            if (withBack) ...[
              Directionality(
                textDirection: context.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: SvgPicture.asset(
                  "AppAssets.arrowForward",
                  matchTextDirection: true,
                  width: 24.r,
                  height: 24.r,
                ).onTap(
                  function: onTapBack ?? () {
                    context.pop();
                  },
                ),
              ),
              widthSpace(12.w),
            ],
            Expanded(
              child: CustomPartSearchBarWidget(
                playSearch: playSearch ?? (){},
                stopSearch: stopSearch ?? (){},
                title: title,
                ctrl: ctrl ?? TextEditingController(),
              ),
            ),
            if(!isShowFilterIcon)...[
              widthSpace(8.w),
              CustomRadiusIcon(
                size: 48.r,
                backgroundColor: AppColors.whiteColor,
                borderColor: AppColors.borderColor,
                borderRadius: BorderRadius.circular(8.r),
                onTap: onTapFilter,
                child: SvgPicture.asset(
                  "AppAssets.filter",
                  width: 20.r,
                  height: 20.r,
                ),
              ),
            ],

          ],
        ),
      ),
    );
  }
}
