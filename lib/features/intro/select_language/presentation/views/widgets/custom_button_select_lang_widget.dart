import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/framework/spaces.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonSelectLangWidget extends StatelessWidget {
  final String image , name ;
  final void Function() onTap ;
  const CustomButtonSelectLangWidget({super.key, required this.image, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 18.h,
            width: 24.w,
          ),
          widthSpace(5.w),
          Flexible(
            child: Text(
              name,
              style: AppTextStyles.textStyle14,
            ),
          ),
        ],
      ),
    );
  }
}
