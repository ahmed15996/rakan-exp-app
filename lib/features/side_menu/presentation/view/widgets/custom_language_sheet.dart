import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/side_menu/presentation/cubit/side_menu_cubit.dart';

import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../generated/locale_keys.g.dart';

class CustomLanguageSheet extends StatelessWidget {
  const CustomLanguageSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SideMenuCubit>(),
      child: BlocBuilder<SideMenuCubit, SideMenuState>(

        builder: (context, state) {
          final cubit=BlocProvider.of<SideMenuCubit>(context);
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 105.w,
                    height: 3.h,
                    decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(20.r)))
                    .center,
                Text("LocaleKeys.changeLanguage.tr()",
                    style: AppTextStyles.textStyle18.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
                    .withPadding(top: 24.h, bottom: 32.h),
                Row(children: [
                  SvgPicture.asset(AppAssets.english, width: 24.r, height: 18.r).withPadding(end: 8.w),
                  Expanded(
                      child: Text(LocaleKeys.english.tr(),
                          style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w400, color: AppColors.blackTextColor))),
                  if (context.locale.languageCode == "en")
                    Icon(Icons.check, size: 20.r, color: AppColors.blackTextColor).withPadding(start: 8.w)
                ]).onTapShadow(
                  borderRadius: BorderRadius.circular(8.r),
                  function: () {
                    if (context.locale.languageCode != "en") {
                      context.setLocale(Locale("en"));
                      cubit.saveLang(lang: "en");
                    }
                    context.pop();
                  },
                ),
                Row(children: [
                  SvgPicture.asset(AppAssets.arabic, width: 24.r, height: 18.r).withPadding(end: 8.w),
                  Expanded(
                      child: Text(LocaleKeys.arabic.tr(),
                          style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w400, color: AppColors.blackTextColor))),
                  if (context.locale.languageCode == "ar")
                    Icon(Icons.check, size: 20.r, color: AppColors.blackTextColor).withPadding(start: 8.w)
                ])
                    .onTapShadow(
                  borderRadius: BorderRadius.circular(8.r),
                  function: () {
                    if (context.locale.languageCode != "ar") {
                      context.setLocale(Locale("ar"));
                      cubit.saveLang(lang: "ar");
                    }
                    context.pop();
                  },
                )
                    .withPadding(vertical: 16.h)
              ],
            ),
          );
        },
      ),
    );
  }
}
