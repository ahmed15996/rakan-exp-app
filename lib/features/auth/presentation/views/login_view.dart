import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/util/routing/routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../widgets/login_widgets/custom_login_form_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<LoginCubit>(context);
            return SafeArea(
              child: Column(
                children: [
                  Image.asset(AppAssets.logo, width: 100.r, height: 100.r).withPadding(top: 40.h, bottom: 16.h),
                  Text(LocaleKeys.login.tr(),
                      style: AppTextStyles.textStyle24.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      )).withPadding(bottom: 16.h),
                  Text(LocaleKeys.enterYourDataToAccessYourAccount.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textStyle18.copyWith(
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.w600,
                      )).withPadding(horizontal: 32.w),
                  CustomLoginFormWidget(cubit: cubit).withPadding(bottom: 80.h),
                  CustomButton(
                    isLoading: state is LoginLoading,
                    onPressed: () async {
                      bool isPhoneNumberValid = await cubit.validatePhoneNumber(cubit.phoneCtrl.text);
                      if (cubit.formKey.currentState!.validate()) {
                        if (isPhoneNumberValid) {
                          if (context.mounted) {
                            cubit.login(context: context);
                          }
                        }
                      }
                    },
                    text: LocaleKeys.login.tr(),
                  ).withPadding(bottom: 24.h),
                  CustomButton(
                          onPressed: () async {
                            context.pushWithNamed(Routes.registerView);
                          },
                          text: LocaleKeys.createAccount.tr())
                      .withPadding(bottom: 24.h),
                  // Text("LocaleKeys.skipLogin.tr()",
                  //     style: AppTextStyles.textStyle12.copyWith(
                  //       color: AppColors.grayTextColor,
                  //       fontWeight: FontWeight.w400,
                  //     )).onTapShadow(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   function: () {
                  //     // context.pushWithNamed(Routes.aqarBrokerNavBarView);
                  //   },
                  // )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
