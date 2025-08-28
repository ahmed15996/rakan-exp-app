import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class CustomOnlineSheet extends StatelessWidget {
  const CustomOnlineSheet({super.key, required this.cubit, required this.state});

  final HomeCubit cubit;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 54.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
          color: AppColors.whiteColor, border: Border.all(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.visibility_off_outlined, size: 22.r, color: AppColors.grayTextColor)
                  .onTapShadow(borderRadius: BorderRadius.circular(8.r), function: () => cubit.openOnlineSheet()),
              Spacer(),
              Image.asset(AppAssets.authLogo, width: 28.r, height: 28.r),
              Spacer(),
              Icon(Icons.visibility_off_outlined, size: 22.r, color: AppColors.transparentColor),
            ],
          ).withPadding(bottom: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                        child: Text(LocaleKeys.activeNow.tr(),
                            style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))),
                    if(cubit.model?.online??false)
                    CircleAvatar(radius: 6.r, backgroundColor: AppColors.greenColor),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Transform.scale(
                    scaleX: .6,
                    scaleY: .5,
                    child: CupertinoSwitch(
                      value: cubit.model?.online ?? false,
                      focusColor: AppColors.hintColor,
                      offLabelColor: AppColors.greenColor,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.whiteColor,
                      inactiveTrackColor: AppColors.hintColor,
                      onChanged: (value) {
                        cubit.updateOnline(isOnline: !(cubit.model?.online ?? false) ? 1 : 0);
                      },
                    )),
              )
            ],
          ),
          Divider(height: 16.h, color: AppColors.greyLightColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(LocaleKeys.dailyIncome.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.blackTextColor))),
              Text(cubit.model?.balance.toString() ?? "",
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor)),
              SvgPicture.asset(AppAssets.sar, width: 24.r, height: 24.r)
            ],
          ),
          Divider(height: 16.h, color: AppColors.greyLightColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(LocaleKeys.dailyOrdersCount.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.blackTextColor))),
              Text(cubit.model?.ordersCount.toString() ?? "",
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor)),
            ],
          ),
          Divider(height: 16.h, color: AppColors.greyLightColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(LocaleKeys.acceptanceRate.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.blackTextColor))),
              Text(cubit.model?.accepted.toString() ?? "",
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}
