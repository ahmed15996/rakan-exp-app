import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/custom_drop_down_field.dart';

class OrdersAppBar extends StatelessWidget {
  const OrdersAppBar({super.key, required this.cubit, required this.state});

  final OrdersCubit cubit;
  final OrdersState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: LocaleKeys.orderHistory.tr()),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteLightColor),
                child: SvgPicture.asset(AppAssets.filter),
              ),
              widthSpace(16.w),
              Flexible(
                child: CustomDropDownField(
                    radius: 500.r,
                    textColor: AppColors.blackTextColor,
                    fillColor: AppColors.whiteLightColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    items: List.generate(
                      cubit.orderTypeList.length,
                      (index) => DropdownMenuItem(
                        value: cubit.orderTypeList[index].id,
                        child: Text(
                          cubit.orderTypeList[index].title,
                          style: AppTextStyles.textStyle13.copyWith(color: AppColors.blackTextColor),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        cubit.orderType = cubit.orderTypeList.firstWhere((element) => element.id.toString() == value);

                        cubit.update();
                      }
                    },
                    value: cubit.orderType?.id,
                    hintText: LocaleKeys.sortBy.tr()),
              ),
              widthSpace(8.w),
              Flexible(
                child: CustomDropDownField(
                    radius: 500.r,
                    textColor: AppColors.blackTextColor,
                    fillColor: AppColors.whiteLightColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    items: List.generate(
                      cubit.typeList.length,
                      (index) => DropdownMenuItem(
                        value: cubit.typeList[index].id,
                        child: Text(
                          cubit.typeList[index].title,
                          style: AppTextStyles.textStyle13.copyWith(color: AppColors.blackTextColor),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        cubit.type = cubit.typeList.firstWhere((element) => element.id.toString() == value);
                        cubit.update();
                      }
                    },
                    value: cubit.type?.id,
                    hintText: LocaleKeys.orderStatus.tr()),
              )
            ],
          ).withPadding(vertical: 8.h, horizontal: 16.w)
        ],
      ),
    );
  }
}
