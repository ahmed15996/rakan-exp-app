import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/util/routing/routes.dart';
import '../../../../static_page/data/arguments/static_page_arguments.dart';

class CustomTextPrivacyAndTermsWidget extends StatelessWidget {
  const CustomTextPrivacyAndTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${LocaleKeys.termsConsent.tr()}\t',
            style: AppTextStyles.textStyle12.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
          TextSpan(
            text: LocaleKeys.termsAndConditions.tr(),
            style: AppTextStyles.textStyle12
                .copyWith(color: AppColors.primaryColor, decorationColor: AppColors.primaryColor, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {

                  context.pushWithNamed(Routes.staticPageView,
                      arguments: StaticPageArguments(title: LocaleKeys.termsAndConditions.tr(), forAbout: false));

              },
          ),
          TextSpan(
            text: ' ${LocaleKeys.app.tr()}\t',
            style: AppTextStyles.textStyle12.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
        ],
      ),
    ).toStart;
  }
}
