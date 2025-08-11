import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/custom_image_network.dart';

class CustomPickImage extends StatelessWidget {
  const CustomPickImage({super.key, required this.title, this.image, this.networkImg, this.onTap});

  final String title;
  final String? image, networkImg;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    print(networkImg);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(title, style: AppTextStyles.textStyle12.copyWith(color: AppColors.grayTextColor, fontWeight: FontWeight.w500))),
            Icon(
              Icons.edit,
              size: 20.r,
              color: AppColors.hintColor,
            ).onTapShadow(
              borderRadius: BorderRadius.circular(8.r),
              function: () {
                if (onTap != null) {
                  onTap!();
                }
              },
            )
          ],
        ).withPadding(bottom: 16.h),
        Container(
            margin: EdgeInsets.only(bottom: 16.h),
            width: double.infinity,
            height: 88.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: AppColors.whiteLightColor, borderRadius: BorderRadius.circular(16.r)),
            child: (image?.isNotEmpty??false)
                ? Image.file(File(image!), width: 72.r, height: 72.r, fit: BoxFit.cover)
                : CustomImageNetwork(image: networkImg??"" , widthImage: 72.r, heightImage: 72.r, fit: BoxFit.cover)),
      ],
    );
  }
}
