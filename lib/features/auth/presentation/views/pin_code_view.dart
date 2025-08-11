import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar_auth.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/util/routing/routes.dart';
import '../../data/arguments/pin_code_argument.dart';
import '../cubits/pin_code_cubit/pin_code_cubit.dart';
import '../widgets/pin_code_widgets/custom_pin_code_text_field_widget.dart';
import '../widgets/pin_code_widgets/custom_resend_code_widget.dart';

class PinCodeView extends StatelessWidget {
  final PinCodeArgument argument;

  const PinCodeView({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PinCodeCubit, PinCodeState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<PinCodeCubit>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(child: const CustomAppBarAuth()),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    children: [
                      Image.asset(AppAssets.logo, width: 100.r, height: 100.r).withPadding(bottom: 16.h),
                      Text(LocaleKeys.login.tr(),
                          style: AppTextStyles.textStyle24.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          )).withPadding(bottom: 16.h),
                      Text(LocaleKeys.enterVerificationCodeSentTo.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.textStyle18.copyWith(
                            color: AppColors.blackTextColor,
                            fontWeight: FontWeight.w600,
                          )).withPadding(horizontal: 32.w, bottom: 16.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cubit.formatPhoneNumberWithLocale(phone: argument.countryCode + argument.phoneNumber, context: context),
                            style: AppTextStyles.textStyle16.copyWith(
                              color: AppColors.blackTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ).withPadding(end: 4.w),
                        ],
                      ).withPadding(bottom: 32.h),
                      const CustomPinCodeTextFieldWidget(),
                      CustomResendCodeWidget(argument: argument).withPadding(bottom: 60.h),
                      CustomButton(
                        onPressed: () {
                          cubit.confirmCode(
                            context: context,
                            phoneNumber: argument.phoneNumber,
                            countryCode: argument.countryCode,
                          );
                        },
                        text: LocaleKeys.verify.tr(),
                        isLoading: state is PinCodeLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ).onTap(
      function: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
