import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/widgets/custom_image_network.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class CustomChatItem extends StatelessWidget {
  const CustomChatItem({super.key, required this.msg, required this.fromSender, required this.img});

  final String msg;
  final bool fromSender;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: fromSender ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        children: [
          CustomImageNetwork(image: img, widthImage: 24.r, heightImage: 24.r),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: AlignmentDirectional.centerStart,
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsetsDirectional.only(end: 16.w, start: 16.w, top: 8.h, bottom: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteLightColor,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(12.r),
                      topEnd: Radius.circular(12.r),
                      bottomStart: Radius.circular(0),
                      bottomEnd: Radius.circular(12.r))),
              child: Text(msg,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w400, color: AppColors.blackTextColor)),
            ),
          ),
        ],
      ),
    );
  }
}
