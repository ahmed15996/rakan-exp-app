import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/notifications/data/models/notification_model.dart';

class CustomNotificationItem extends StatelessWidget {
  const CustomNotificationItem({super.key, required this.model});

  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      color: AppColors.borderPinkColor,
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 32.r,
                height: 32.r,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration( shape: BoxShape.circle),
                child: SvgPicture.asset(
                  AppAssets.notify,
                  fit: BoxFit.cover,
                )).withPadding(end: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(model.title, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w400, color: AppColors.blackTextColor))
                      .withPadding(bottom: 8.h),
                  Text(model.message ?? "",
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
                ],
              ),
            ),
            Text(model.createdAt ?? "",
                style: AppTextStyles.textStyle10.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)).toBottomEnd,
          ],
        ),
      ),
    );
  }
}
