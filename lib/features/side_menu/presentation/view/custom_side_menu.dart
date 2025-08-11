import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/di/di.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/side_menu/presentation/cubit/side_menu_cubit.dart';
import 'package:rakaan/features/side_menu/presentation/view/widgets/custom_bottom_sheet_delete_acc.dart';
import 'package:rakaan/features/side_menu/presentation/view/widgets/custom_bottom_sheet_log_out.dart';
import 'package:rakaan/features/side_menu/presentation/view/widgets/custom_drawer_row.dart';
import 'package:rakaan/features/side_menu/presentation/view/widgets/custom_side_menu_header.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/util/routing/routes.dart';
import '../../../static_page/data/arguments/static_page_arguments.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SideMenuCubit>(),
      child: BlocBuilder<SideMenuCubit, SideMenuState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<SideMenuCubit>(context);
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.whiteColor,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSideMenuHeader(cubit: cubit, state: state),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteLightColor),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomDrawerRow(
                              title: LocaleKeys.notifications.tr(),
                              image: AppAssets.notifications,
                              onTap: () => context.pushWithNamed(Routes.notificationsView)),
                          CustomDrawerRow(
                              title: LocaleKeys.wallet.tr(),
                              image: AppAssets.wallet,
                              onTap: () => context.pushWithNamed(Routes.walletView)),
                          CustomDrawerRow(title: LocaleKeys.orderHistory.tr(), image: AppAssets.orders, onTap: () {
                            context.pushWithNamed(Routes.orderView);
                          },),
                          CustomDrawerRow(
                            title: LocaleKeys.analytics.tr(),
                            image: AppAssets.static,
                            onTap: () {
                              context.pushWithNamed(Routes.staticsView);
                            },
                          ),
                          CustomDrawerRow(title: LocaleKeys.guidelines.tr(), image: AppAssets.info, isLast: true,onTap: () {
                            context.pushWithNamed(Routes.learnView);
                          },),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteLightColor),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomDrawerRow(
                            title: LocaleKeys.contactUs.tr(),
                            image: AppAssets.headphone,
                            onTap: () {
                              context.pushWithNamed(Routes.contactUsView);
                            },
                          ),
                          CustomDrawerRow(
                            title: LocaleKeys.termsAndConditions.tr(),
                            image: AppAssets.terms,
                            onTap: () {
                              context.pushWithNamed(Routes.staticPageView,
                                  arguments: StaticPageArguments(title: LocaleKeys.termsAndConditions.tr(), forAbout: false));
                            },
                          ),
                          CustomDrawerRow(
                              title: LocaleKeys.faq.tr(), image: AppAssets.faq, onTap: () => context.pushWithNamed(Routes.faqView)),
                          CustomDrawerRow(
                            title: LocaleKeys.aboutUs.tr(),
                            image: AppAssets.about,
                            isLast: true,
                            onTap: () {
                              context.pushWithNamed(Routes.staticPageView,
                                  arguments: StaticPageArguments(title: LocaleKeys.aboutUs.tr(), forAbout: true));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteLightColor),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Directionality(
                                      textDirection: context.locale.languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
                                      child: SvgPicture.asset(AppAssets.deleteAccount, width: 24.r, matchTextDirection: true, height: 24.r))
                                  .withPadding(end: 12.w),
                              Expanded(
                                  child: Text(LocaleKeys.deleteAccount.tr(),
                                      style:
                                          AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))),
                            ],
                          ).onTapShadow(
                            borderRadius: BorderRadius.circular(8.r),
                            function: () {
                              showModalBottomSheet(
                                context: context,
                                constraints: BoxConstraints(maxWidth: context.width),
                                isScrollControlled: true,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<SideMenuCubit>(),
                                  child: const CustomBottomSheetDeleteAcc(),
                                ),
                              );
                            },
                          ),
                          Divider(
                            height: 24.h,
                            color: AppColors.greyLightColor,
                          ),
                          Row(
                            children: [
                              Directionality(
                                      textDirection: context.locale.languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
                                      child: SvgPicture.asset(AppAssets.logout, width: 24.r, matchTextDirection: true, height: 24.r))
                                  .withPadding(end: 12.w),
                              Expanded(
                                  child: Text(LocaleKeys.logout.tr(),
                                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.redColor))),
                            ],
                          ).onTapShadow(
                            borderRadius: BorderRadius.circular(8.r),
                            function: () {
                              showModalBottomSheet(
                                context: context,
                                constraints: BoxConstraints(maxWidth: context.width),
                                isScrollControlled: true,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<SideMenuCubit>(),
                                  child: const CustomBottomSheetLogOut(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
