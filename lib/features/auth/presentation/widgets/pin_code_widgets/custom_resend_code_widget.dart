import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../data/arguments/pin_code_argument.dart';
import '../../cubits/pin_code_cubit/pin_code_cubit.dart';

class CustomResendCodeWidget extends StatefulWidget {
  final PinCodeArgument argument;

  const CustomResendCodeWidget({super.key, required this.argument});

  @override
  State<CustomResendCodeWidget> createState() => _CustomResendCodeWidgetState();
}

class _CustomResendCodeWidgetState extends State<CustomResendCodeWidget> {
  var interval = const Duration(seconds: 1);
  int timerMaxSeconds = 60;
  int currentSeconds = 0;
  late Timer timer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  bool get isFinish => currentSeconds >= timerMaxSeconds;

  void startTimer() {
    Timer.periodic(interval, (time) {
      timer = time;
      debugPrint(timer.tick.toString());
      currentSeconds = timer.tick;
      if (timer.tick >= timerMaxSeconds) {
        timer.cancel();
        debugPrint("Finish Timer ");
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          heightSpace(15.h),
          Text.rich(
            TextSpan(
              children: isFinish
                  ? [
                      TextSpan(
                        text: '${LocaleKeys.didNotReceiveVerificationCode.tr()}\t',
                        style: AppTextStyles.textStyle14.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                      ),
                      TextSpan(
                        text: LocaleKeys.resend.tr(),
                        style: AppTextStyles.textStyle14.copyWith(
                            color: AppColors.secondaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.secondaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<PinCodeCubit>().resendCode(
                                  phoneNumber: widget.argument.phoneNumber,
                                  countryCode: widget.argument.countryCode,
                                  timer: startTimer,
                                );
                          },
                      ),
                    ]
                  : [
                      TextSpan(
                        text: '${LocaleKeys.didNotReceiveVerificationCode.tr()}\t',
                        style: AppTextStyles.textStyle14.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                      ),
                      TextSpan(
                        text: timerText,
                        style: AppTextStyles.textStyle14.copyWith(
                            color: AppColors.secondaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.secondaryColor),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
