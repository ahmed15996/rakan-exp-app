import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomPartOfCustomError extends StatelessWidget {
  final String error ;
  const CustomPartOfCustomError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          error == LocaleKeys.noInternetError.tr()
              ? AppAssets.noInternet
              : AppAssets.defaultError,
          height:error == LocaleKeys.noInternetError.tr()
              ? context.height / 5.2
              : context.height / 4.55 ,
          width: error == LocaleKeys.noInternetError.tr()
              ? context.width / 2.4
              : context.width / 1.5,
        ),
        heightSpace(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Text(
            error,
            style: AppTextStyles.textStyle14.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        heightSpace(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            error == LocaleKeys.noInternetError.tr()
                ? LocaleKeys.youShouldInternet.tr()
                : LocaleKeys.youShouldGlobalProblem.tr(),
            style: AppTextStyles.textStyle14.copyWith(
              color: AppColors.grayTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
