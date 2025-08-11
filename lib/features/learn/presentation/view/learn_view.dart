import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error.dart';
import '../cubit/learn_cubit.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnCubit, LearnState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<LearnCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.guidelines.tr()),
              state is LearnFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData()))
                  : state is LearnLoading || state is LearnInitial
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.learnTitle.tr(),
                                    style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w600, color: AppColors.blackTextColor))
                                .withPadding(top: 16.h),
                            Text(LocaleKeys.link.tr(),
                                    style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w600, color: AppColors.primaryColor))
                                .onTapShadow(
                                  borderRadius: BorderRadius.circular(8.r),
                                  function: () {
                                    if (cubit.data != null) {
                                      cubit.openYouTubeUrl(cubit.data!);
                                    } else {
                                      showToast(text: "Link is empty,please try again later", state: ToastStates.error);
                                    }
                                  },
                                )
                                .withPadding(top: 16.h),
                          ],
                        ).center)
            ],
          ),
        );
      },
    );
  }
}
