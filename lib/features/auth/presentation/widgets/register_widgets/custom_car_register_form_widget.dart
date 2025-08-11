import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_image_network.dart';
import 'package:rakaan/core/widgets/custom_text_form_field.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/framework/app_validator.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../cubits/register_cubit/register_cubit.dart';
import 'custom_text_privacy_and_terms_widget.dart';

class CustomCarRegisterFormWidget extends StatelessWidget {
  final RegisterCubit cubit;

  const CustomCarRegisterFormWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.deliveryMethodInformation.tr(),
              style: AppTextStyles.textStyle14.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              )).withPadding(bottom: 24.h),
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
                          size: 20.r, color:cubit.cars[index].id==cubit.carModel?.id?AppColors.blackLightColor: AppColors.grayTextColor)
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
          CustomTextFormField(
            ctrl: cubit.licenceImg,
            label: LocaleKeys.licensePhoto.tr(),
            validator: AppValidator.requiredValidator(),
            hintText: LocaleKeys.uploadLicensePhoto.tr(),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: Icon(Icons.file_upload_outlined, size: 20.r, color: AppColors.grayTextColor),
            readOnly: true,
            onTap: () {
              cubit.pickLicenceImage();
            },
          ).withPadding(bottom: 16.h),
          CustomTextFormField(
            ctrl: cubit.formImg,
            label: LocaleKeys.vehicleRegistrationPhoto.tr(),
            validator: AppValidator.requiredValidator(),
            hintText: LocaleKeys.vehicleRegistrationPhoto.tr(),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: Icon(Icons.file_upload_outlined, size: 20.r, color: AppColors.grayTextColor),
            readOnly: true,
            onTap: () {
              cubit.pickFormImage();
            },
          ).withPadding(bottom: 16.h),
          CustomTextFormField(
            ctrl: cubit.carImg,
            label: LocaleKeys.vehiclePhoto.tr(),
            validator: AppValidator.requiredValidator(),
            hintText: LocaleKeys.vehiclePhoto.tr(),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: Icon(Icons.file_upload_outlined, size: 20.r, color: AppColors.grayTextColor),
            readOnly: true,
            onTap: () {
              cubit.pickCarImage();
            },
          ).withPadding(bottom: 32.h),
          CustomTextPrivacyAndTermsWidget(),
        ],
      ),
    );
  }
}
