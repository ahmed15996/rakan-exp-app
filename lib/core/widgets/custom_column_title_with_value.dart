// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../generated/locale_keys.g.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
// import '../framework/spaces.dart';
//
// class CustomColumnTitleWithValue extends StatelessWidget {
//   final String title;
//   final String? value;
//
//   final bool isPrice;
//   final Widget? widget;
//
//   const CustomColumnTitleWithValue({
//     super.key,
//     required this.title,
//     this.value,
//     this.widget,
//     this.isPrice = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           title,
//           style: AppTextStyles.textStyle12.copyWith(
//             fontWeight: FontWeight.w400,
//             color: AppColors.grayHintTextColor,
//           ),
//         ),
//         if (widget != null) ...[
//           widget!,
//         ],
//         if (widget == null) ...[
//           if (isPrice)
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: value,
//                     style: AppTextStyles.textStyle12.copyWith(
//                       color: AppColors.blackTextColor,
//                     ),
//                   ),
//                   WidgetSpan(child: widthSpace(1.w)),
//                   TextSpan(
//                     text: LocaleKeys.sar.tr(),
//                     style: AppTextStyles.textStyle11,
//                   ),
//                 ],
//               ),
//             ),
//           if (!isPrice)
//             Text(
//               value!,
//               style: AppTextStyles.textStyle12.copyWith(
//                 color: AppColors.blackTextColor,
//               ),
//             ),
//         ],
//       ],
//     );
//   }
// }
