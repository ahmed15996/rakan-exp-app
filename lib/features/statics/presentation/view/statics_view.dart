import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/statics/presentation/view/widgets/custom_static_item.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/statics_cubit.dart';

class StaticsView extends StatelessWidget {
  const StaticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticsCubit, StaticsState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<StaticsCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.analytics.tr()),
              state is StaticsFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData()))
                  : state is StaticsLoading || state is StaticsInitial
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : Expanded(
                          child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                CustomStaticItem(
                                    title: LocaleKeys.todayOrdersCount.tr(), value: cubit.model?.ordersCountToday.toString()??"0", img: AppAssets.ordersCount, isPrice: false),
                                SizedBox(width: 16.w),
                                CustomStaticItem(
                                    title: LocaleKeys.todayEarnings.tr(), value: cubit.model?.walletToday.toString()??"0", img: AppAssets.walletCount, isPrice: true),
                              ],
                            ).withPadding(bottom: 24.h),
                            Row(
                              children: [
                                CustomStaticItem(
                                    title: LocaleKeys.totalOrdersCount.tr(), value: cubit.model?.ordersCount.toString()??"0", img: AppAssets.ordersCount, isPrice: false),
                                SizedBox(width: 16.w),
                                CustomStaticItem(
                                    title: LocaleKeys.totalEarnings.tr(), value: cubit.model?.wallet.toString()??"0", img: AppAssets.walletCount, isPrice: true),
                              ],
                            ),
                          ]),
                        ))
            ],
          ),
        );
      },
    );
  }
}
