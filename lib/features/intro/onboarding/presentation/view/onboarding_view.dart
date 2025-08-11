import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_circle_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/util/routing/routes.dart';
import '../../../../../core/widgets/custom_error.dart';
import '../../../../../core/widgets/custom_image_network.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../cubit/on_boarding_cubit.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<OnBoardingCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: state is OnBoardingFailed
                ? CustomError(error: state.msg, retry: cubit.getData)
                : Skeletonizer(
                    enabled: state is OnBoardingLoading,
                    child: Column(
                      children: [
                        if (!cubit.isLast)
                          Text(LocaleKeys.skip.tr(), style: AppTextStyles.textStyle14.copyWith(color: AppColors.secondaryColor))
                              .toTopStart
                              .withPadding(horizontal: 24.w, top: 24.h)
                              .onTapShadow(
                                borderRadius: BorderRadius.circular(8.r),
                                function: () {
                                  cubit.onSkip();
                                },
                              ),
                        if (cubit.isLast)
                          Text("test", style: AppTextStyles.textStyle14.copyWith(color: AppColors.transparentColor))
                              .toTopStart
                              .withPadding(horizontal: 24.w, top: 24.h),
                        Spacer(),
                        SizedBox(
                          height: 376.h,
                          child: PageView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              reverse: false,
                              itemCount: cubit.list.length,
                              controller: cubit.pageViewController,
                              itemBuilder: (context, index) => CustomImageNetwork(
                                    image: cubit.list[index].image ?? "",
                                    heightImage: 270.h,
                                    widthImage: double.infinity,
                                    fit: BoxFit.fill,
                                  )),
                        ).withPadding(top: 8.h),
                        Wrap(
                            spacing: 8.w,
                            children: List.generate(
                                cubit.list.length,
                                (index) => Container(
                                      height: 2.h,
                                      width: cubit.currentIndex == index ? 28.w : 8.w,
                                      decoration: BoxDecoration(
                                          color: cubit.currentIndex == index ? AppColors.secondaryColor : AppColors.hintColor,
                                          borderRadius: BorderRadius.circular(24.r)),
                                    ))).withPadding(top: 32.h),
                        Text(cubit.list[cubit.currentIndex].title??"", maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.textStyle18)
                            .withPadding(top: 40.h, bottom: 16.h, horizontal: 32.w),
                        Text(cubit.list[cubit.currentIndex].desc??"",
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor))
                            .withPadding(bottom: 8.h, horizontal: 32.w),
                        Spacer(),
                        Skeleton.replace(
                          replace: state is OnBoardingLoading,
                          child: CustomRadiusIcon(
                            onTap: () {
                              if (cubit.isLast) {
                                context.pushAndRemoveUntilWithNamed(Routes.loginView);
                              } else {
                                cubit.onUpdate(index: cubit.currentIndex + 1);
                              }
                            },
                            size: 40.r,
                            backgroundColor: AppColors.primaryColor,
                            child: SvgPicture.asset(AppAssets.onboardingBtn, fit: BoxFit.fill),
                          ).toBottomStart.withPadding(horizontal: 16.w).withPadding(bottom: 46.h),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

/*

 */
