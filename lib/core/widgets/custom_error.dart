import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/locale_keys.g.dart';
import '../constants/app_assets.dart';
import '../framework/spaces.dart';
import 'custom_button.dart';
import 'custom_part_of_custom_error.dart';

class CustomError extends StatelessWidget {
  final String error;

  final void Function() retry;
  final bool? isLogo;

  const CustomError({
    super.key,
    required this.error,
    required this.retry,
    this.isLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return isLogo == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.authLogo,
                height: context.height * 0.05,
                width: context.width * 0.32,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPartOfCustomError(
                        error: error,
                      ),
                      heightSpace(15.h),
                      CustomButton(
                        onPressed: retry,
                        text: LocaleKeys.retry.tr(),
                        height: context.height * 0.057,
                        width: context.width * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : SizedBox(
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPartOfCustomError(
                  error: error,
                ),
                heightSpace(15.h),
                CustomButton(
                  onPressed: retry,
                  text: LocaleKeys.retry.tr(),
                  height: context.height * 0.057,
                  width: context.width * 0.55,
                ),
              ],
            ),
          );
  }
}
