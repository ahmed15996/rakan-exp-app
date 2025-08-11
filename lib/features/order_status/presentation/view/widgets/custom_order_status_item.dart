import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';
import 'package:rakaan/features/order_status/presentation/cubit/order_status_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomOrderStatusItem extends StatelessWidget {
  const CustomOrderStatusItem({super.key, required this.cubit, required this.state, required this.model});

  final OrderStatusCubit cubit;
  final OrderStatusState state;
  final TripModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 7.r, backgroundColor: AppColors.primaryColor),
            Expanded(
              child: LinearProgressIndicator(
                value: 1,
                color: model.status?.id == 2||model.status?.id == 3||model.status?.id == 4 ?
                AppColors.primaryColor : AppColors.hintColor,
              ),
            ),
            CircleAvatar(radius: 7.r, backgroundColor:
            model.status?.id == 2||model.status?.id == 3||model.status?.id == 4 ?
            AppColors.primaryColor :
            AppColors.hintColor),
            Expanded(
                child: LinearProgressIndicator(
                    value: 1,
                    color:   model.status?.id == 3||model.status?.id == 4
                        ? AppColors.primaryColor
                        : AppColors.hintColor)),
            CircleAvatar(
                radius: 7.r,
                backgroundColor: model.status?.id == 3||model.status?.id == 4
                    ? AppColors.primaryColor
                    : AppColors.hintColor)
          ],
        ).withPadding(bottom: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(LocaleKeys.reachRestaurant.tr(),
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
            ),
            Expanded(
              child: Text(LocaleKeys.orderReceived.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
            ),
            Expanded(
              child: Text(LocaleKeys.orderDelivered.tr(),
                  textAlign: TextAlign.end,
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
            ),
          ],
        )
      ],
    ).withPadding(vertical: 24.h);
  }
}
