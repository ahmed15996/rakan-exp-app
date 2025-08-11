import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';
import 'package:rakaan/features/order_status/data/arguments/order_status_arguments.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/util/routing/routes.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../home/presentation/view/widgets/custom_delivery_item.dart';
import '../../../data/models/order_model.dart';

class CustomBrokerOrderItem extends StatelessWidget {
  const CustomBrokerOrderItem({super.key, required this.model, this.onUpdate});

  final TripModel model;
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(color: AppColors.whiteLightColor, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Row(
            children: [
              Text(LocaleKeys.orderNumber.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                  .withPadding(end: 2.w),
              Text("#${45875}", style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
              Spacer(),
              Text(LocaleKeys.orderDetails.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor))
                  .withPadding(end: 2.w),
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 16.r,
                color: AppColors.hintColor,
              )
            ],
          ).withPadding(horizontal: 16.w),

          CustomDeliveryItem(
            provider: model.serviceProvider!,
            client: model.clint!,
            time:model.time ?? "",
          ).withPadding(top: 24.h)
        ],
      ),
    ).onTapShadow(
      borderRadius: BorderRadius.circular(8.r),
      function: () {
        context.pushWithNamed(Routes.orderStatusView, arguments: OrderStatusArguments(model: model));
      },
    );
  }
}
