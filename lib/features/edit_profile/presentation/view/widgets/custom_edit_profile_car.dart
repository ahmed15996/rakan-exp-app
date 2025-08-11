import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/widgets/custom_image_network.dart';
import '../../cubit/edit_profile_cubit.dart';
import 'custom_pick_image.dart';

class CustomEditProfileCar extends StatelessWidget {
  const CustomEditProfileCar({super.key, required this.cubit, required this.state});

  final EditProfileCubit cubit;
  final EditProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.deliveryMethodInformation.tr(),
            style: AppTextStyles.textStyle14.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            )).withPadding(bottom: 8.h),
        Text(LocaleKeys.deliveryVehicleType.tr(),
            style: AppTextStyles.textStyle14.copyWith(
              color: AppColors.blackTextColor,
              fontWeight: FontWeight.w500,
            )).withPadding(bottom: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            cubit.cars.length,
            (index) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(cubit.cars[index].id == cubit.carModel?.id ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                        size: 20.r, color: cubit.cars[index].id == cubit.carModel?.id ? AppColors.blackLightColor : AppColors.grayTextColor)
                    .withPadding(end: 8.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageNetwork(image: cubit.cars[index].img ?? "", widthImage: 45.r, heightImage: 45.r),
                    Text(
                      cubit.cars[index].name ?? "",
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.blackTextColor),
                    )
                  ],
                )
              ],
            ).onTapShadow(
              borderRadius: BorderRadius.circular(8.r),
              function: () {
                cubit.selectCarType(model: cubit.cars[index]);
              },
            ),
          ),
        ).withPadding(bottom: 16.h),
        CustomPickImage(
            title: LocaleKeys.licensePhoto.tr(),
            image: cubit.licenceImg.text,
            networkImg: cubit.pref.getData(key: AppCached.licenseImg),
            onTap: () {
              cubit.pickLicenceImage();
            }),
        CustomPickImage(
            title: LocaleKeys.vehicleRegistrationPhoto.tr(),
            image: cubit.formImg.text,
            networkImg: cubit.pref.getData(key: AppCached.formImg),
            onTap: () {
              cubit.pickFormImage();
            }),
        CustomPickImage(
            title: LocaleKeys.vehiclePhoto.tr(),
            image: cubit.carImg.text,
            networkImg: cubit.pref.getData(key: AppCached.carImg),
            onTap: () {
              cubit.pickCarImage();
            }),
      ],
    );
  }
}
