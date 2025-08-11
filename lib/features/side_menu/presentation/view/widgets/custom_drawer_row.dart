import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

class CustomDrawerRow extends StatelessWidget {
  const CustomDrawerRow({super.key, required this.title, required this.image, this.onTap,  this.isLast=false});

  final String title, image;
  final void Function()? onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Directionality(
                    textDirection: context.locale.languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
                    child: SvgPicture.asset(image, width: 24.r, matchTextDirection: true, height: 24.r))
                .withPadding(end: 12.w),
            Expanded(
                child:
                    Text(title, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.blackTextColor,
              size: 20.r,
            )
          ],
        ),
        if(!isLast)
        Divider(
          height: 24.h,
          color: AppColors.greyLightColor,
        )
      ],
    ).withPadding(horizontal: 16.w).onTapShadow(
          borderRadius: BorderRadius.circular(8.r),
          function: () {
            if (onTap != null) {
              onTap!();
            }
          },
        );
  }
}
