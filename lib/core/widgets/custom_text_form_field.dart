import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController ctrl;
  final String? label, hintText, optionLabel;
  final TextStyle? hintStyle, style, labelStyle;
  final TextInputType? keyboardType;
  final Widget? suffixIcon, prefixIcon;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly, enabled, isPass;
  final int? maxLines;
  final int? minLines;
  final double? borderRadiusValue;
  final Color? borderColor, backGroundColor;

  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final AutovalidateMode? autoValidateMode;
  final TextAlign? textAlign;

  final TextDirection? textDirection;

  const CustomTextFormField({
    super.key,
    required this.ctrl,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.minLines,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.optionLabel,
    this.readOnly = false,
    this.isPass = false,
    this.maxLines = 1,
    this.autoValidateMode,
    this.onChanged,
    this.onTap,
    this.borderRadiusValue,
    this.contentPadding,
    this.hintStyle,
    this.labelStyle,
    this.enabled = true,
    this.textAlign,
    this.textDirection,
    this.borderColor,
    this.backGroundColor,
    this.style,
    this.label,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;

  void changeVisibility() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.label != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  widget.label!,
                  style: widget.labelStyle ??
                      AppTextStyles.textStyle14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackTextColor,
                      ),
                ),
              ),
            if (widget.optionLabel != null)
              Text(
                widget.optionLabel!,
                style: widget.labelStyle ??
                    AppTextStyles.textStyle13.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grayTextColor,
                    ),
              )
          ],
        ),
        Skeleton.shade(
          child: TextFormField(
            minLines: widget.minLines,
            keyboardType: widget.keyboardType,
            controller: widget.ctrl,
            enabled: widget.enabled,
            obscureText: isVisible,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onTap: widget.onTap,
            scrollPadding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            style: widget.style ??
                AppTextStyles.textStyle13.copyWith(
                  color: AppColors.blackTextColor,
                ),
            textAlign: widget.textAlign ?? TextAlign.start,
            textDirection: widget.textDirection,
            cursorColor: AppColors.primaryColor,
            cursorErrorColor: AppColors.redColor,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly!,
            validator: widget.validator,
            maxLines: widget.maxLines,
            autovalidateMode: widget.autoValidateMode,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backGroundColor ?? AppColors.whiteColor,
              border: buildOutlineInputBorder(widget.borderColor),
              suffixIcon: widget.isPass!
                  ? IconButton(
                      onPressed: () {
                        changeVisibility();
                      },
                      icon: SvgPicture.asset(
                        !isVisible
                            ? "AppAssets.unVisibility"
                            : "AppAssets.visibility",
                        height: 19.h,
                        width: 19.w,
                      ),
                    )
                  : widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: BoxConstraints(maxHeight: 40.r,maxWidth: 40.r
              ),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  AppTextStyles.textStyle10.copyWith(
                    color: AppColors.grayTextColor,
                    fontWeight: FontWeight.w400
                  ),
              focusedBorder: buildOutlineInputBorder(
                  widget.borderColor ?? AppColors.primaryColor),
              enabledBorder: buildOutlineInputBorder(widget.borderColor),
              errorBorder: buildOutlineInputBorder(AppColors.redColor),
              focusedErrorBorder: buildOutlineInputBorder(AppColors.redColor),
              errorStyle: AppTextStyles.textStyle13.copyWith(
                color: AppColors.redColor,
              ),
              errorMaxLines: 2,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
              isDense: true,
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadiusValue ?? 8.r),
      borderSide: BorderSide(
        color: color ?? AppColors.borderColor,
        width: 0.75.w,
      ),
    );
  }
}
