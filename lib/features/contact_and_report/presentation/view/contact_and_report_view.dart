import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/core/widgets/custom_text_form_field.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/framework/app_validator.dart';
import '../../../../core/widgets/custom_drop_down_field.dart';
import '../cubit/contact_and_report_cubit.dart';

class ContactAndReportView extends StatefulWidget {
  const ContactAndReportView({super.key});

  @override
  State<ContactAndReportView> createState() => _ContactAndReportViewState();
}

class _ContactAndReportViewState extends State<ContactAndReportView> {
  @override
  void initState() {
    super.initState();

    context.read<ContactAndReportCubit>().msgType = LocaleKeys.report.tr();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactAndReportCubit, ContactAndReportState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ContactAndReportCubit>(context);
        return Form(
          key: cubit.formKey,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: LocaleKeys.contactUs.tr()),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.contactHelpText.tr(),
                        style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
                      ).withPadding(bottom: 24.h),
                      CustomTextFormField(
                              label: LocaleKeys.fullName.tr(),
                              hintText: LocaleKeys.fullName.tr(),
                              backGroundColor: AppColors.whiteLightColor,
                              borderColor: AppColors.graySemiBoldColor,
                              validator: AppValidator.nameValidator(),
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              ctrl: cubit.nameController)
                          .withPadding(bottom: 16.h),
                      CustomTextFormField(
                              label: LocaleKeys.email.tr(),
                              hintText: LocaleKeys.email.tr(),
                              backGroundColor: AppColors.whiteLightColor,
                              borderColor: AppColors.graySemiBoldColor,
                              validator: AppValidator.emailValidator(),
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              ctrl: cubit.emailController)
                          .withPadding(bottom: 16.h),
                      CustomDropDownField(
                              label: LocaleKeys.reasonForContact.tr(),
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              items: List.generate(
                                cubit.messageTypeList.length,
                                (index) => DropdownMenuItem(
                                  value: cubit.messageTypeList[index],
                                  child: Text(
                                    cubit.messageTypeList[index],
                                    style: AppTextStyles.textStyle13.copyWith(color: AppColors.blackTextColor),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  cubit.selectType(type: value);
                                }
                              },
                              value: cubit.msgType,
                              hintText: LocaleKeys.reasonForContact.tr())
                          .withPadding(bottom: 16.h),
                      CustomTextFormField(
                              label: LocaleKeys.message.tr(),
                              hintText: LocaleKeys.messagePlaceholder.tr(),
                              maxLines: 5,
                              backGroundColor: AppColors.whiteLightColor,
                              borderColor: AppColors.graySemiBoldColor,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              ctrl: cubit.messageController)
                          .withPadding(bottom: 64.h),
                      CustomButton(
                          text: LocaleKeys.submit.tr(),
                          isLoading: state is ContactAndReportLoading,
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.addContact(context: context);
                            }
                          })
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
