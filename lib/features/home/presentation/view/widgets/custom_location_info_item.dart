import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

class CustomLocationInfoItem extends StatelessWidget {
  const CustomLocationInfoItem(
      {super.key,
      required this.titleType,
      required this.name,
      required this.desc,
      required this.distance,
      required this.withLine,
      this.img,
      this.onTap});

  final String titleType, name, desc, distance;
  final bool withLine;
  final String? img;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(AppAssets.location, width: 12.r, height: 12.r),
            if (withLine)
              SizedBox(
                  width: 1.w,
                  child: LinearProgressIndicator(
                    color: AppColors.blackColor,
                    minHeight: 48.h,
                    value: 1,
                  )),
          ],
        ).withPadding(end: 8.w),
        Text(titleType, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
            .withPadding(end: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(name, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
                        .withPadding(bottom: 4.h)
                  ),
        if (img != null)
          SvgPicture.asset(img!, width: 40.r, height: 40.r).onTapShadow(
            borderRadius: BorderRadius.circular(8.r),
            function: () {
              if (onTap != null) {
                onTap!();
              }
            },).withPadding(end: 6.w)
                ],
              ),
              Text(desc, style: AppTextStyles.textStyle8.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor)),
            ],
          ),
        ),
        Text(distance, style: AppTextStyles.textStyle10.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
      ],
    );
  }
}
