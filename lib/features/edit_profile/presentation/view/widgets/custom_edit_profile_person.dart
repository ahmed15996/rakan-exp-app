import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/edit_profile/presentation/view/widgets/custom_edit_profile_user_image.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/framework/app_validator.dart';
import '../../../../../core/widgets/custom_drop_down_field.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/custom_text_phone_field.dart';
import '../../cubit/edit_profile_cubit.dart';

class CustomEditProfilePerson extends StatelessWidget {
  const CustomEditProfilePerson({super.key, required this.cubit, required this.state});

  final EditProfileCubit cubit;
  final EditProfileState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.personalInformation.tr(),
              style: AppTextStyles.textStyle14.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              )).withPadding(bottom: 16.h),
          CustomEditProfileUserImage(cubit: cubit, state: state),
          CustomTextFormField(
            ctrl: cubit.nameCtrl,
            label: LocaleKeys.fullName.tr(),
            validator: AppValidator.nameValidator(),
            hintText: LocaleKeys.fullName.tr(),
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ).withPadding(bottom: 16.h),
          CustomTextFormField(
            ctrl: cubit.emailCtrl,
            label: LocaleKeys.email.tr(),
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.emailValidator(),
            hintText: LocaleKeys.email.tr(),
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ).withPadding(bottom: 16.h),
          CustomTextPhoneField(
            controller: cubit.phoneCtrl,
            countryCode: cubit.countryCode,
            validate: (value) => cubit.validatePhoneNumber(value),
            onChangedCountryCode: (value) => cubit.changeCountryCode(value),
            readOnly: true,
            borderColor: AppColors.borderColor,
          ).withPadding(bottom: 16.h),
          CustomDropDownField(
                  label: LocaleKeys.city.tr(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: AppValidator.requiredValidator(),
                  items: List.generate(
                    cubit.cities.length,
                    (index) => DropdownMenuItem(
                      value: cubit.cities[index].id.toString(),
                      child: Text(
                        cubit.cities[index].name ?? "",
                        style: AppTextStyles.textStyle13.copyWith(color: AppColors.blackTextColor),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      cubit.selectCity(model: cubit.cities.firstWhere((element) => element.id.toString() == value));
                    }
                  },
                  value: cubit.cityModel?.id.toString(),
                  hintText: LocaleKeys.city.tr())
              .withPadding(bottom: 16.h),
        ],
      ),
    );
  }
}
