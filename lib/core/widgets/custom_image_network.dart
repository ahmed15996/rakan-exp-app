import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/locale_keys.g.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../framework/spaces.dart';

class CustomImageNetwork extends StatelessWidget {
  final double? heightImage, widthImage, heightLoading, widthLoading, heightImageError, widthImageError, strokeWidth, widthBigImageLoading;

  final BoxFit? fit;
  final Color? color, colorLoading;

  final String image;
  final TextStyle? textStyleProblemImage, textStyleLoading;
  final bool? isShowText, isBigLoading;

  const CustomImageNetwork(
      {super.key,
      this.heightImage,
      this.widthImage,
      this.fit,
      required this.image,
      this.textStyleProblemImage,
      this.heightImageError,
      this.widthImageError,
      this.isShowText = false,
      this.isBigLoading = false,
      this.heightLoading,
      this.widthLoading,
      this.strokeWidth,
      this.textStyleLoading,
      this.widthBigImageLoading,
      this.color,
      this.colorLoading});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      height: heightImage,
      width: widthImage,
      color: color,
      placeholder: (context, url) => isBigLoading == false
          ? Center(
              child: SizedBox(
                height: heightLoading ?? 20.r,
                width: widthLoading ?? 20.r,
                child: CircularProgressIndicator(
                  color: colorLoading ?? AppColors.primaryColor,
                  strokeWidth: strokeWidth ?? 4.w,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_search_sharp, size: 12.r, color: AppColors.hintColor),
                heightSpace(10.h),
                Text(
                  LocaleKeys.loading.tr(),
                  style: textStyleLoading ??
                      AppTextStyles.textStyle16.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
      errorWidget: (context, url, error) => isShowText == false
          ?  Center(
              child:   Icon(Icons.image_not_supported_outlined, size: 12.r, color: AppColors.hintColor),
              )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SvgPicture.asset(
                  //   AppAssets.noImage,
                  //   height: heightImageError,
                  //   width: widthImageError,
                  // ),
                  heightSpace(10.h),
                  Text(
                    LocaleKeys.images.tr(),
                    style: textStyleProblemImage ??
                        AppTextStyles.textStyle10.copyWith(
                          color: AppColors.blackColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
