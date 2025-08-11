import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_text_phone_field.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../cubits/login_cubit/login_cubit.dart';

class CustomLoginFormWidget extends StatelessWidget {
  final LoginCubit cubit;

  const CustomLoginFormWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.phoneNumber.tr(),
            style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor),
          ).withPadding(top: 32.h, bottom: 10.h),
          CustomTextPhoneField(
            controller: cubit.phoneCtrl,
            countryCode: cubit.countryCode,
            validate: (value) => cubit.validatePhoneNumber(value),
            onChangedCountryCode: (value) => cubit.changeCountryCode(value),
          ),
        ],
      ),
    );
  }
}
