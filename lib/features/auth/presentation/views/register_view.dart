import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/core/widgets/custom_error.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/custom_app_bar_auth.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/register_cubit/register_cubit.dart';
import '../widgets/register_widgets/custom_car_register_form_widget.dart';
import '../widgets/register_widgets/custom_person_register_form_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<RegisterCubit>(context);
            return Column(
              children: [
                SafeArea(child: const CustomAppBarAuth()),
                state is GetDataLoading || state is RegisterInitial
                    ? Expanded(
                        child: SizedBox(
                        height: 24.r,
                        child: CircularProgressIndicator(color: AppColors.primaryColor).center,
                      ))
                    : state is GetDataFailure
                        ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getCars()))
                        : Expanded(
                            child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                child: Column(
                                  children: [
                                    Text(LocaleKeys.createAccount.tr(),
                                        style: AppTextStyles.textStyle24.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w700,
                                        )).withPadding(bottom: 16.h),
                                    Text(LocaleKeys.enterYourDataToCreateAccountAndSubmitRequest.tr(),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.textStyle18.copyWith(
                                          color: AppColors.blackTextColor,
                                          fontWeight: FontWeight.w600,
                                        )).withPadding(bottom: 20.h),
                                    LinearProgressIndicator(
                                      value: cubit.isFirstStep ? .5 : 1,
                                      backgroundColor: AppColors.hintColor,
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(24.r),
                                      minHeight: 3.5.h,
                                    ),
                                    heightSpace(30.h),
                                    if (cubit.isFirstStep) CustomPersonRegisterFormWidget(cubit: cubit),
                                    if (!cubit.isFirstStep) CustomCarRegisterFormWidget(cubit: cubit),
                                    heightSpace(20.h),
                                    CustomButton(
                                      isLoading: state is RegisterLoading,
                                      onPressed: () async {
                                        bool? isValidate = cubit.formKey.currentState?.validate();
                                        bool? isPhoneNumberValid = await cubit.validatePhoneNumber(cubit.phoneCtrl.text);
                                        if (isValidate! && isPhoneNumberValid) {
                                          if (context.mounted) {
                                            if (cubit.isFirstStep) {
                                              cubit.selectStep();
                                            } else {
                                              if (cubit.carModel == null) {
                                                showToast(text: LocaleKeys.selectCarFirst.tr(), state: ToastStates.error);
                                              } else {
                                                cubit.register(context: context);
                                              }
                                            }
                                          }
                                        }
                                      },
                                      text: cubit.isFirstStep ? LocaleKeys.next.tr() : LocaleKeys.createAccount.tr(),
                                    ).withPadding(top: 40.h, bottom: 24.h),
                                  ],
                                )),
                          ),
              ],
            );
          },
        ),
      ),
    );
  }
}
