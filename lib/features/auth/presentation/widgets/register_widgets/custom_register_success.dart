import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/util/routing/routes.dart';

class CustomRegisterSuccess extends StatefulWidget {
  const CustomRegisterSuccess({super.key});

  @override
  State<CustomRegisterSuccess> createState() => _CustomRegisterSuccessState();
}

class _CustomRegisterSuccessState extends State<CustomRegisterSuccess> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushAndRemoveUntilWithNamed(Routes.loginView);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, color: Colors.grey),
            ),
          ).withPadding(bottom: 10.h),
          SvgPicture.asset(
            AppAssets.registerSuccess,
            width: 80.r,
            height: 80.r,
          ).withPadding(bottom: 20.h),
          Text(
            LocaleKeys.registerSuccess.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ).withPadding(all: 20.r),
    );
  }
}
