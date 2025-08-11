import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import 'custom_country_picker.dart';

class CustomTextPhoneField extends StatefulWidget {
  final double? borderRadiusValue;
  final Color? borderColor;
  final bool readOnly;
  final TextEditingController controller;
  final CountryCode countryCode;
  final Future<bool> Function(String)? validate;
  final void Function(CountryCode)? onChangedCountryCode;
  final String? Function(String?)? validator;

  const CustomTextPhoneField(
      {super.key,
      this.borderRadiusValue,
      this.readOnly=false,
      this.borderColor,
      required this.controller,
      required this.countryCode,
      this.onChangedCountryCode,
      this.validator,
      this.validate});

  @override
  State<CustomTextPhoneField> createState() => _CustomTextPhoneFieldState();
}

class _CustomTextPhoneFieldState extends State<CustomTextPhoneField> {
  bool isPhoneNumberValid = false;

  Future<void> validatePhoneNumber(String value) async {
    if (widget.validate != null) {
      final isValid = await widget.validate!(value);
      setState(() {
        isPhoneNumberValid = isValid;
      });
    }
  }

  @override
  void initState() {
    validatePhoneNumber(widget.controller.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (value) async {
        if (value.isNotEmpty) {
          await validatePhoneNumber(value);
        }
      },readOnly: widget.readOnly,
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      style: AppTextStyles.textStyle13.copyWith(
        color: AppColors.blackTextColor,
      ),
      textAlign: TextAlign.start,
      cursorColor: AppColors.primaryColor,
      cursorErrorColor: AppColors.redColor,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteColor,
        prefixIcon: AbsorbPointer(
          absorbing: true,
          child: CustomCountryPicker(
            countryCode: widget.countryCode,
            onChangedCountryCode: widget.onChangedCountryCode,
          ),
        ),
        border: buildOutlineInputBorder(widget.borderColor),
        disabledBorder: buildOutlineInputBorder(widget.borderColor),
        focusedBorder: buildOutlineInputBorder(AppColors.primaryColor),
        enabledBorder: buildOutlineInputBorder(widget.borderColor),
        errorBorder: buildOutlineInputBorder(AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(AppColors.redColor),
        errorStyle: AppTextStyles.textStyle13.copyWith(
          color: AppColors.redColor,
        ),
        errorMaxLines: 2,
        hintText: LocaleKeys.enterPhone.tr(),
        hintStyle: AppTextStyles.textStyle10.copyWith(color: AppColors.grayTextColor, fontWeight: FontWeight.w400),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
        isDense: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocaleKeys.emptyPhone.tr();
        }

        if (!isPhoneNumberValid) {
          return LocaleKeys.validatePhone.tr();
        }
        return null;
      },
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
