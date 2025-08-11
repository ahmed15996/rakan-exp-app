import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_text_styles.dart';

class CustomDropDownField extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final String? label;
  final double? radius;
  final void Function(String?) onChanged;
  final String? Function(String? value)? validator;
  final String? value;
  final Color? fillColor, textColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autoValidateMode;

  const CustomDropDownField(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.value,
      required this.hintText,
      this.validator,
      this.contentPadding,
      this.labelStyle,
      this.radius,
      this.textColor,
      this.fillColor,
      this.autoValidateMode,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: labelStyle ??
                AppTextStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackTextColor,
                ),
          ).withPadding(bottom: 14.h),
        DropdownButtonFormField<String>(
            dropdownColor: AppColors.whiteColor,
            style: AppTextStyles.textStyle13.copyWith(
              color: AppColors.blackTextColor,
              fontFamily: AppConstants.cairo,
            ),
            value: value,
            items: items,
            hint: Text(
              hintText,
              style: AppTextStyles.textStyle10.copyWith(color: textColor ?? AppColors.grayTextColor, fontWeight: FontWeight.w400),
            ),
            validator: validator,
            isDense: true,
            iconSize: 26.r,
            autovalidateMode: autoValidateMode,
            borderRadius: BorderRadius.circular(8.r),
            padding: EdgeInsets.zero,
            decoration: InputDecoration(
              isDense: true,
              hintStyle: AppTextStyles.textStyle13.copyWith(
                color: AppColors.grayTextColor,
                fontFamily: AppConstants.cairo,
              ),
              focusedBorder: buildOutlineInputBorder(AppColors.borderColor),
              enabledBorder: buildOutlineInputBorder(AppColors.borderColor),
              errorBorder: buildOutlineInputBorder(AppColors.redColor),
              focusedErrorBorder: buildOutlineInputBorder(AppColors.redColor),
              errorStyle: AppTextStyles.textStyle13.copyWith(
                color: AppColors.redColor,
                fontFamily: AppConstants.cairo,
              ),
              errorMaxLines: 2,
              contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
              filled: true,
              fillColor: fillColor ?? AppColors.whiteColor,
            ),
            onChanged: onChanged,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 24.r,
              color: textColor ?? AppColors.grayTextColor,
            )),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 8.r),
      borderSide: BorderSide(
        color: color ?? AppColors.borderColor,
        width: 0.75.w,
      ),
    );
  }
}
