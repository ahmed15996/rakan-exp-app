import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/helpers/custom_pin_code_controller.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../cubits/pin_code_cubit/pin_code_cubit.dart';

class CustomPinCodeTextFieldWidget extends StatefulWidget {
  const CustomPinCodeTextFieldWidget({super.key});

  @override
  State<CustomPinCodeTextFieldWidget> createState() => _CustomPinCodeTextFieldWidgetState();
}

class _CustomPinCodeTextFieldWidgetState extends State<CustomPinCodeTextFieldWidget> {
  late PinCodeController pinCodeController;
  late TextEditingController controller;

  void _controllerListener() {
    setState(() {});
  }

  @override
  void initState() {
    pinCodeController = PinCodeController()..addListener(_controllerListener);
    context.read<PinCodeCubit>().pinCodeController = pinCodeController;
    controller = pinCodeController.controller;
    super.initState();
  }

  @override
  void dispose() {
    pinCodeController = PinCodeController()..removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            appContext: context,
            length: 4,
            controller: controller,
            scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            animationType: AnimationType.none,
            onChanged: (String? value) {
              if (value != null) {
                pinCodeController.validatePinCode();
              }
            },
            errorTextDirection: context.locale.languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textStyle: AppTextStyles.textStyle18,
            pastedTextStyle: AppTextStyles.textStyle18,
            autovalidateMode: AutovalidateMode.always,
            cursorColor: AppColors.primaryColor,
            enableActiveFill: true,
            autoDisposeControllers: false,
            enablePinAutofill: true,
            keyboardType: TextInputType.number,
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              return true;
            },
            pinTheme: PinTheme(
              fieldWidth: 64.r,
              fieldHeight: 64.r,
              borderRadius: BorderRadius.circular(12.r),
              disabledColor: AppColors.blackTextColor,
              inactiveColor: borderColor(),
              errorBorderColor: AppColors.redColor,
              selectedColor: AppColors.primaryColor,
              activeColor: AppColors.primaryColor,
              selectedBorderWidth: 1.w,
              errorBorderWidth: 1.w,
              activeBorderWidth: 1.w,
              disabledBorderWidth: 1.w,
              inactiveBorderWidth: 1.w,
              borderWidth: 1.w,
              selectedFillColor: AppColors.whiteColor,
              activeFillColor: AppColors.whiteColor,
              inactiveFillColor: AppColors.whiteColor,
              shape: PinCodeFieldShape.box,
            ),
          ),
        ),
        if (pinCodeController.pinCodeFieldBorder == PinCodeFieldBorder.error) ...[
          heightSpace(3.h),
          Text(
            pinCodeController.errorMessage,
            style: AppTextStyles.textStyle13.copyWith(
              color: AppColors.redColor,
            ),
          ),
        ]
      ],
    );
  }

  Color borderColor() {
    switch (pinCodeController.pinCodeFieldBorder) {
      case PinCodeFieldBorder.initial:
        return AppColors.borderColor;
      case PinCodeFieldBorder.error:
        return AppColors.redColor;
      case PinCodeFieldBorder.validated:
        return AppColors.borderColor;
    }
  }
}
