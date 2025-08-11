import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../data/models/wallet_model.dart';

class CustomWalletItem extends StatelessWidget {
  const CustomWalletItem({super.key, required this.model});

  final WalletModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 16.h),
    color: AppColors.transparentColor,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAssets.wallet, width: 24.r, height: 24.r).withPadding(end: 6.w),
              Text(LocaleKeys.code.tr(),
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
              Text("#${model.id}", style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
              Spacer(),
              Text("${model.symbol}${model.balance} ${LocaleKeys.currencySar.tr()}",
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor))
            ],
          ).withPadding(bottom: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(model.msg ?? "",
                    style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
              ),
              Text(model.createdAt??"", style: AppTextStyles.textStyle10.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor)),
            ],
          )
        ],
      ),
    );
  }
}
