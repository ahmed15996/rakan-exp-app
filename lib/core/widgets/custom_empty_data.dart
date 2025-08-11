import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomEmptyData extends StatelessWidget {
  final String image, text;
  final double? height, width;
  

  const CustomEmptyData({
    super.key,
    required this.image,
    required this.text,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: height ?? context.height * 0.11,
            width: width ?? context.width * 0.6,

          ),
          heightSpace(15.h),
          Text(
            text,
            style: AppTextStyles.textStyle15.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
