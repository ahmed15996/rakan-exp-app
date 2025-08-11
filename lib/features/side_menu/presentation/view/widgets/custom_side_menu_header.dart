import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_image_network.dart';
import 'package:rakaan/features/side_menu/presentation/cubit/side_menu_cubit.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_cached.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/util/routing/routes.dart';
import '../../../data/arguments/edit_profile_argument.dart';

class CustomSideMenuHeader extends StatelessWidget {
  const CustomSideMenuHeader({super.key, required this.cubit, required this.state});

  final SideMenuCubit cubit;
  final SideMenuState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.close, color: AppColors.transparentColor, size: 22.r),
            Image.asset(AppAssets.logo, width: 32.r, height: 32.r),
            Icon(Icons.close, color: AppColors.blackColor, size: 22.r).onTapShadow(
              borderRadius: BorderRadius.circular(8.r),
              function: () => context.pop(),
            )
          ],
        ).withPadding(top: 20.h, bottom: 24.h, horizontal: 24.w),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteLightColor),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CustomImageNetwork(
                 image:   cubit.pref.getData(key: AppCached.img)??"",
                  widthImage: 40.r,
                  heightImage: 40.r,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.pref.getData(key: AppCached.name),
                      style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor),
                    ),
                    // Icon(
                    //   Icons.star,
                    //   color: AppColors.secondaryColor,
                    //   size: 14.r,
                    // )
                  ],
                ).withPadding(horizontal: 8.w),
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.blackTextColor,
                size: 20.r,
              )
            ],
          ),
        ).withPadding(horizontal: 16.w, bottom: 24.h).onTapShadow(
            borderRadius: BorderRadius.circular(8.r),
            function: () => context.pushWithNamed(Routes.editProfileView, arguments: EditProfileArgument(
              onUpdate: () {
                cubit.update();
              },
            )))
      ],
    );
  }
}
