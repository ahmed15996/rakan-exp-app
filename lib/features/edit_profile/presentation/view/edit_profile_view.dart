import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/features/edit_profile/presentation/view/widgets/custom_edit_profile_car.dart';
import 'package:rakaan/features/edit_profile/presentation/view/widgets/custom_edit_profile_person.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/framework/spaces.dart';
import '../../../side_menu/data/arguments/edit_profile_argument.dart';
import '../cubit/edit_profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.argument});

  final EditProfileArgument argument;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          if (argument.onUpdate != null) {
            argument.onUpdate!();
            context.pop();
          }
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<EditProfileCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.profile.tr()),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomEditProfilePerson(cubit: cubit, state: state),
                    CustomEditProfileCar(cubit: cubit, state: state),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            isLoading: state is EditProfileLoading,
                            text: LocaleKeys.save.tr(),
                            onPressed: () {
                              if (cubit.cityModel != null) {
                                cubit.editProfile(context: context);
                              } else {
                                showToast(text: LocaleKeys.selectCarFirst.tr(), state: ToastStates.error);
                              }
                            },
                          ),
                        ),
                        widthSpace(16.w),
                        Expanded(
                          child: CustomButton(
                            text: LocaleKeys.back.tr(),
                            textColor: AppColors.whiteColor,
                            borderSide: BorderSide(color: AppColors.hintColor),
                            backgroundColor: AppColors.hintColor,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
