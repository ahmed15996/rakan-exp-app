import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/features/side_menu/presentation/cubit/side_menu_cubit.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/framework/spaces.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../edit_profile/presentation/cubit/edit_profile_cubit.dart';

class CustomBottomSheetDeleteAcc extends StatelessWidget {
  const CustomBottomSheetDeleteAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(16.r),
          topStart: Radius.circular(16.r),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 5.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
            ),
            heightSpace(30.h),
            Text(
             LocaleKeys.deleteAccountConfirmation.tr(),
              style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor),
            ),
            heightSpace(20.h),
            Text(
             LocaleKeys.deleteAccountWarning.tr(),
              style: AppTextStyles.textStyle12.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.grayTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            heightSpace(40.h),
            BlocBuilder<SideMenuCubit, SideMenuState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<SideMenuCubit>(context);
                return CustomButton(
                  isLoading: state is DeleteAccountLoading,
                  text: LocaleKeys.deleteAccount.tr(),
                  style: AppTextStyles.textStyle14.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  colorLoading: AppColors.whiteColor,
                  backgroundColor: AppColors.grayTextColor,
                  height: 48.h,
                  onPressed: () {
                    cubit.deleteAccount(context: context);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
