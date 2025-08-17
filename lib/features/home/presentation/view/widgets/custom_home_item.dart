import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import 'custom_delivery_item.dart';
import 'custom_timer_widget.dart';

class CustomHomeItem extends StatefulWidget {
  const CustomHomeItem({super.key, required this.model, required this.time});

  final TripModel model;
  final int time;

  @override
  State<CustomHomeItem> createState() => _CustomHomeItemState();
}

class _CustomHomeItemState extends State<CustomHomeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(color: AppColors.whiteLightColor, borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(

            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(widget.model.delivery.toString(),
                          style: AppTextStyles.textStyle32.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackColor)),
                      SvgPicture.asset(AppAssets.sar, width: 48.r, height: 48.r)
                    ],
                  ),
                  Text(LocaleKeys.newDeliveryRequest.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                ],
              ),
              Flexible(child: CustomTimerWidget(model: widget.model, time: widget.time))
            ],
          ).withPadding(horizontal: 16.w),
          Divider(color: AppColors.whiteColor, thickness: 8.h, height: 28.h),
          Row(
            children: [
              Text(LocaleKeys.orderNumber.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                  .withPadding(end: 2.w),
              Text("#${widget.model.code}",
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
              Spacer(),
              Text(LocaleKeys.orderDetails.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor))
                  .onTapShadow(
                    borderRadius: BorderRadius.circular(8.r),
                    function: () {
                      widget.model.isOpen = !widget.model.isOpen!;
                      setState(() {});
                    },
                  )
                  .withPadding(end: 2.w),
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 16.r,
                color: AppColors.primaryColor,
              )
            ],
          ).withPadding(horizontal: 16.w),
          if (widget.model.isOpen!)
            CustomDeliveryItem(
              provider: widget.model.serviceProvider!,
              client: widget.model.clint!,
              time: widget.model.time ?? "",
            ).withPadding(top: 24.h)
        ],
      ),
    );
  }
}
