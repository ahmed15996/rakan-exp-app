import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

class CustomCountryPicker extends StatelessWidget {
  final CountryCode countryCode;

  final void Function(CountryCode)? onChangedCountryCode;

  const CustomCountryPicker({super.key, required this.countryCode, this.onChangedCountryCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 16.w),
      decoration: BoxDecoration(
        color: AppColors.transparentColor,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(8.r),
          bottomStart: Radius.circular(8.r),
        ),
        border: BorderDirectional(
          end: BorderSide(
            color: AppColors.borderColor,
            width: 0.75.w,
          ),
        ),
      ),
      child: CountryCodePicker(
        enabled: true,
        hideCloseIcon: true,
        initialSelection: countryCode.dialCode,
        onChanged: onChangedCountryCode,
        padding: EdgeInsets.symmetric(vertical: 13.h),
        dialogItemPadding: EdgeInsetsDirectional.only(top: 15.h, bottom: 10.h),
        searchPadding: EdgeInsetsDirectional.only(
          start: 12.w,
          end: 12.w,
          top: 15.h,
        ),
        searchStyle: AppTextStyles.textStyle13.copyWith(
          color: AppColors.blackTextColor,
        ),
        emptySearchBuilder: (context) => SizedBox(
          height: context.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.notFound.tr(),
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
        searchDecoration: InputDecoration(
          isDense: true,
          fillColor: AppColors.whiteLightColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
          hintText: LocaleKeys.search.tr(),
          hintStyle: AppTextStyles.textStyle11.copyWith(
            color: AppColors.grayTextColor,
          ),
          border: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(AppColors.primaryColor),
          enabledBorder: buildOutlineInputBorder(),
        ),
        builder: (country) => Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Image.asset(
                    country!.flagUri!,
                    package: 'country_code_picker',
                    width: 25.w,
                    height: 18.h,
                  ),
                ),
                widthSpace(5.w),
                Flexible(
                  child: Text(
                    country.dialCode!,
                    style: AppTextStyles.textStyle13.copyWith(
                      color: AppColors.grayTextColor,
                    ),
                  ),
                ),
                widthSpace(5.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: color ?? AppColors.borderColor,
        width: 0.75.w,
      ),
    );
  }
}
