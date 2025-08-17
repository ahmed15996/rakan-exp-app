import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/framework/app_validator.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_text_form_field.dart';
import 'package:rakaan/core/widgets/custom_text_phone_field.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/custom_drop_down_field.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../cubits/register_cubit/register_cubit.dart';

class CustomPersonRegisterFormWidget extends StatelessWidget {
  final RegisterCubit cubit;

  const CustomPersonRegisterFormWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.personalInformation.tr(),
            style: AppTextStyles.textStyle14.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            )).withPadding(bottom: 16.h),
        CustomTextFormField(
          ctrl: cubit.nameCtrl,
          label: LocaleKeys.fullName.tr(),
          validator: AppValidator.nameValidator(),
          hintText: LocaleKeys.fullName.tr(),
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ).withPadding(bottom: 16.h),
        Text(LocaleKeys.phoneNumber.tr(),
            style: AppTextStyles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackTextColor,
            )).withPadding(bottom: 8.h),
        CustomTextPhoneField(
          controller: cubit.phoneCtrl,
          countryCode: cubit.countryCode,
          validate: (value) => cubit.validatePhoneNumber(value),
          onChangedCountryCode: (value) => cubit.changeCountryCode(value),
        ).withPadding(bottom: 16.h),
        CustomTextFormField(
          ctrl: cubit.idNumCtrl,
          label: LocaleKeys.identityNumber.tr(),
          keyboardType: TextInputType.number,
          validator: AppValidator.requiredValidator(),
          hintText: LocaleKeys.identityNumber.tr(),
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ).withPadding(bottom: 16.h),
        CustomTextFormField(
          ctrl: cubit.birthDay,
          label: LocaleKeys.birthDate.tr(),
          validator: AppValidator.requiredValidator(),
          hintText: LocaleKeys.birthDate.tr(),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          readOnly: true,
          onTap: () async {
            await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30000)),
                    lastDate: DateTime.now())
                .then((value) {
              if (value != null) {
                cubit.birthDay.text = DateFormat('yyyy-MM-dd', "en").format(value);
              }
            });
          },
        ).withPadding(bottom: 16.h),
        CustomTextFormField(
          ctrl: cubit.emailCtrl,
          label: LocaleKeys.email.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: AppValidator.requiredValidator(),
          hintText: LocaleKeys.email.tr(),
          autoValidateMode: AutovalidateMode.onUserInteraction,
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
    );
  }
}
