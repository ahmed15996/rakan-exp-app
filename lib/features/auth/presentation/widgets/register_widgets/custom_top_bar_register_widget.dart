import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

class CustomTopBarRegisterWidget extends StatelessWidget {
  const CustomTopBarRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace(30.h),
        SvgPicture.asset(
          AppAssets.authLogo,
          height: context.height * 0.05,
          width: context.width * 0.32,
        ),
        heightSpace(30.h),
        Text(
          LocaleKeys.createNewAcc.tr(),
          style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor),
        ),
      ],
    );
  }
}
