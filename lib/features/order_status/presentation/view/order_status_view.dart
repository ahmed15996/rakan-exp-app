import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/features/order_status/presentation/view/widgets/custom_order_status_item.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/helpers/enums.dart';
import '../../../home/presentation/view/widgets/custom_delivery_item.dart';
import '../../data/arguments/order_status_arguments.dart';
import '../cubit/order_status_cubit.dart';

class OrderStatusView extends StatelessWidget {
  const OrderStatusView({super.key, required this.arguments});

  final OrderStatusArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderStatusCubit, OrderStatusState>(
      listener: (context, state) {
        if (state is OrderStatusSuccess) {
          if (context.read<OrderStatusCubit>().model != null) {
            arguments.model = context.read<OrderStatusCubit>().model!;
            if (arguments.onUpdate != null) {
              arguments.onUpdate!();
            }
          }
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<OrderStatusCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.orderDetails.tr()),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(LocaleKeys.orderNumber.tr(),
                                style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                            .withPadding(end: 2.w),
                        Text("#${arguments.model.code}",
                            style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
                        Spacer(),
                        Text(arguments.model.status?.name ?? "",
                                style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor))
                            .withPadding(end: 2.w),
                      ],
                    ),
                    CustomDeliveryItem(
                      provider: arguments.model.serviceProvider!,
                      client: arguments.model.clint!,
                    ).withPadding(top: 24.h),
                    Divider(height: 32.h, color: AppColors.whiteLightColor, thickness: 10.h),
                    Text(LocaleKeys.orderStatus.tr(),
                        style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
                    CustomOrderStatusItem(cubit: cubit, state: state, model: arguments.model),
                    if (arguments.model.status?.id != 4 && arguments.model.status?.id != 5)
                      Text(LocaleKeys.attachStageImage.tr(),
                          style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
                    if (arguments.model.status?.id != 4 && arguments.model.status?.id != 5)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                        width: double.infinity,
                        height: 136.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: AppColors.whiteLightColor,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: AppColors.borderColor)),
                        child: cubit.img != null
                            ? Image.file(File(cubit.img!), height: 136.r, fit: BoxFit.cover)
                            : Icon(Icons.camera_alt_outlined, size: 32.r, color: AppColors.hintColor),
                      ).onTapShadow(
                          borderRadius: BorderRadius.circular(8.r),
                          function: () {
                            cubit.pickImage(
                                id: arguments.model.id.toString(),
                                statusType: arguments.model.status?.id == 1
                                    ? StatusType.accept
                                    : arguments.model.status?.id == 2
                                        ? StatusType.receive
                                        : StatusType.deliver);
                          }),
                    if (arguments.model.status?.id != 4 && arguments.model.status?.id != 5)
                      CustomButton(
                        text: arguments.model.status?.id == 1
                            ? LocaleKeys.arrivedAtRestaurant.tr()
                            : arguments.model.status?.id == 2
                                ? LocaleKeys.orderReceived.tr()
                                : LocaleKeys.orderDelivered.tr(),
                        isLoading: state is OrderStatusLoading,
                        onPressed: () {
                          if (cubit.img != null && state is! UpdateImgLoading) {
                            cubit.changeStatus(
                                id: arguments.model.id.toString(),
                                statusType: arguments.model.status?.id == 1
                                    ? StatusType.accept
                                    : arguments.model.status?.id == 2
                                        ? StatusType.receive
                                        : StatusType.deliver);
                          } else {
                            showToast(text: LocaleKeys.attachStageImage.tr(), state: ToastStates.error);
                          }
                        },
                      ).withPadding(vertical: 24.h)
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
