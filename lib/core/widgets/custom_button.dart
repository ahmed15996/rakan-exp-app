import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/widgets/custom_loading.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final void Function() onPressed;
  final double? height, width, strokeWidth, textSize;
  final Color? backgroundColor, colorLoading, textColor;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;

  final EdgeInsets? padding;

  final String? text;
  final TextStyle? style;
  final bool? isLoading;

  const CustomButton({
    super.key,
    this.child,
    this.text,
    this.style,
    this.textSize,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.isLoading = false,
    this.borderRadius,
    this.padding,
    this.strokeWidth,
    this.textColor,
    this.borderSide,
    this.colorLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor ?? AppColors.primaryColor),
        elevation: const WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
        fixedSize: WidgetStatePropertyAll(Size(width ?? double.infinity, height ?? 48.h)),
        minimumSize: WidgetStatePropertyAll(Size(width ?? double.infinity, height ?? 48.h)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(16.r)),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStatePropertyAll(
          borderSide ?? BorderSide.none,
        ),
      ),
      child: Center(
        child: isLoading == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: child ??
                        Text(
                          text!,
                          style: style ?? AppTextStyles.textStyle14.copyWith(fontSize: textSize, color: textColor),
                        ),
                  ),
                  widthSpace(7.w),
                  CustomLoading(
                    isButton: true,
                    strokeWidth: strokeWidth ?? 3.5.w,
                    color: colorLoading,
                  ),
                ],
              )
            : child ??
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: style ?? AppTextStyles.textStyle14.copyWith(fontSize: textSize, color: textColor),
                ),
      ),
    );
  }
}
