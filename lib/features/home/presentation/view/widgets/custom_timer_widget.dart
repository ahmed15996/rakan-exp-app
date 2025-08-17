import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/util/routing/routes.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../trip_details/data/arguments/trip_details_arguments.dart';
import '../../../data/models/trip_model.dart';

class CustomTimerWidget extends StatefulWidget {
  const CustomTimerWidget({
    super.key,
    required this.model,
    required this.time,
     this.withTap=true,

  });

  final TripModel model;
  final int time;
  final bool withTap;

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  late int time;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    time = widget.time;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // حساب نسبة اللون الأزرق من إجمالي الوقت
    double blueWidthRatio = time / widget.time;

    return Container(
      width: 100.w,

      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.hintColor, // الخلفية الرمادية
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            SizedBox(

              height: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: blueWidthRatio>0?blueWidthRatio:0,
                  heightFactor: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor, // اللون الأزرق
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.acceptOrder.tr(),
                  style: AppTextStyles.textStyle12.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ).withPadding(bottom: 2.h),
                Text(
                  "$time ${LocaleKeys.seconds.tr()}",
                  style: AppTextStyles.textStyle12.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ).center.withPadding(horizontal: 16.w,vertical:8.h ),
          ],
        ),
      ),
    ).toEnd.onTapShadow(
      borderRadius: BorderRadius.circular(8.r),
      function: () {
        if(widget.withTap) {
          context.pushWithNamed(
          Routes.tripDetailsView,
          arguments: TripDetailsArguments(
            id: widget.model.id.toString(),
            second: time,
          ),
        );
        }
      }
    );
  }
}