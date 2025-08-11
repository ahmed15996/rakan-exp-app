import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBarAuth extends StatelessWidget {
  final bool? isSkip;
  final void Function()? onSkip;

  const CustomAppBarAuth({
    super.key,
    this.isSkip = false,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 15.w,
        end: 15.w,
        top: 20.h,

      ),
      child: Row(
        mainAxisAlignment:
            isSkip! ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: isSkip!
            ? [
                Directionality(
                  textDirection: context.locale.languageCode=="ar"?TextDirection.ltr:TextDirection.rtl,
                  child: SvgPicture.asset(

                         AppAssets.arrow,
                    height: 24.h,
                    width: 24.w,
                    matchTextDirection: true,
                  ).onTap(
                    function: () {
                      context.pop();
                    },
                  ),
                ),
                Text(
                  LocaleKeys.skip.tr(),
                  style: AppTextStyles.textStyle14.copyWith(
                    color: AppColors.blackColor,
                  ),
                ).onTap(
                  function: onSkip!,
                ),
              ]
            : [
                Directionality(
                  textDirection: context.locale.languageCode=="ar"?TextDirection.ltr:TextDirection.rtl,
                  child: SvgPicture.asset(
                    AppAssets.arrow,
                    height: 24.h,
                    width: 24.w,
                  ).onTap(
                    function: () {
                      context.pop();
                    },
                  ),
                ),
              ],
      ),
    );
  }
}
