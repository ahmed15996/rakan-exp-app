import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/util/routing/routes.dart';
import 'package:rakaan/core/widgets/custom_circle_icon.dart';
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import 'custom_online_sheet.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.cubit, required this.state});

  final HomeCubit cubit;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Row(
          children: [
            CustomRadiusIcon(
              size: 38.r,
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              backgroundColor: AppColors.whiteColor,
              child: SvgPicture.asset(AppAssets.sideMenu, width: 24.r, height: 24.r),
            ),
            Spacer(),
            CustomRadiusIcon(
              size: 38.r,
              onTap: () {
                context.pushWithNamed(Routes.chatView);
              },
              backgroundColor: AppColors.whiteColor,
              child: SvgPicture.asset(AppAssets.headphone, width: 24.r, height: 24.r),
            ),
          ],
        ),
        if (cubit.isOpenOnlineSheet) CustomOnlineSheet(cubit: cubit, state: state),
        if (!cubit.isOpenOnlineSheet)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 5.r, backgroundColor: (cubit.model?.online ?? false) ? AppColors.greenColor : AppColors.hintColor)
                    .withPadding(end: 4.w, top: 2.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(LocaleKeys.offers.tr(),
                        style: AppTextStyles.textStyle10.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor)),
                    Text("%${cubit.model?.accepted ?? 0} ",
                        style: AppTextStyles.textStyle10.copyWith(fontWeight: FontWeight.w700, color: AppColors.primaryColor)),
                  ],
                )
              ],
            ),
          ).onTapShadow(borderRadius: BorderRadius.circular(8.r), function: () => cubit.openOnlineSheet())
      ],
    ).withPadding(horizontal: 16.w, vertical: 20.h));
  }
}
