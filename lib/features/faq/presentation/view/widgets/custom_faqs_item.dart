import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';

import '../../../data/models/faq_model.dart';

class CustomFaqsItem extends StatefulWidget {
  const CustomFaqsItem({super.key, required this.model});
  final FaqModel model;

  @override
  State<CustomFaqsItem> createState() => _CustomFaqsItemState();
}

class _CustomFaqsItemState extends State<CustomFaqsItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
               widget.model.title,
                style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor),
              ),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              size: 26.r,
            ),
          ],
        ).onTapShadow(
            borderRadius: BorderRadius.circular(8.r),
            function: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            }),
        if (isExpanded)
          Text(
            widget.model.desc??"",
            style: AppTextStyles.textStyle16.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
          ).withPadding(top: 8.h),
        Divider(height: 24.h),
      ],
    );
  }
}
