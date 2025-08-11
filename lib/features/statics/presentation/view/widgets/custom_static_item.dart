import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class CustomStaticItem extends StatelessWidget {
  const CustomStaticItem({super.key, required this.title, required this.value, required this.isPrice, required this.img});

  final String title, value,img;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), border: Border.all(color: AppColors.greyLightColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(child: Text(value, style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w700, color: AppColors.primaryColor))),
                if (isPrice)
                  SvgPicture.asset(
                    AppAssets.sar,
                    width: 16.r,
                    height: 16.r,
                  )
              ],
            ),
            Text(title, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
            SvgPicture.asset(
             img,
              width: 32.r,
              height: 32.r,
            ).toBottomEnd
          ],
        ),
      ),
    );
  }
}
