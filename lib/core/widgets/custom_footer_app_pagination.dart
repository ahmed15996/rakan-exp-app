import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/locale_keys.g.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomFooterAppPagination extends StatefulWidget {
  const CustomFooterAppPagination({super.key});

  @override
  State<CustomFooterAppPagination> createState() =>
      _CustomFooterAppPaginationState();
}

class _CustomFooterAppPaginationState extends State<CustomFooterAppPagination> {
  LoadStatus? mode;

  void changeMode(LoadStatus? newMode) {
    if (mode != newMode) {
      setState(() {
        mode = newMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: mode == LoadStatus.noMore ? 20.h :40.h,
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          changeMode(mode);
        });
        if (mode == LoadStatus.loading) {
          body = Padding(
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            child: Center(
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 4.w,
                ),
              ),
            ),
          );
        } else if (mode == LoadStatus.failed) {
          body = Padding(
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            child: Text(
              LocaleKeys.loadFailed.tr(),
              style: AppTextStyles.textStyle14.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Padding(
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            child: Text(
              LocaleKeys.releaseToLoadMore.tr(),
              style: AppTextStyles.textStyle14.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          body = const SizedBox.shrink();
        }
        return body;
      },
    );
  }
}
