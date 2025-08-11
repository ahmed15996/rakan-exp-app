import 'package:rakaan/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../constants/app_fonts.dart';

class CustomTapBar extends StatelessWidget {
  final TabController tabController;
  final List<String> textList;

  const CustomTapBar({super.key, required this.tabController, required this.textList});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: AppColors.transparentColor,
      dividerHeight: 2.h,
      indicatorWeight: 2.h,
      labelStyle: TextStyle(fontSize: AppFonts.t14, fontFamily: AppConstants.cairo, fontWeight: FontWeight.w500),
      unselectedLabelColor: AppColors.graySemiBoldColor,
      indicatorColor: AppColors.secondaryColor,
      labelColor: AppColors.secondaryColor,
      labelPadding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      tabs: List.generate(textList.length, (index) => Tab(text: textList[index])),
    );
  }
}
