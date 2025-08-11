import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../home/presentation/view/widgets/custom_delivery_item.dart';
import 'open_id.dart';

class CustomTripHeader extends StatelessWidget {
  const CustomTripHeader({super.key, required this.cubit, required this.time});

  final TripDetailsCubit cubit;
final int time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Row(
            children: [
              Text(LocaleKeys.orderNumber.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                  .withPadding(end: 2.w),
              Text("#${cubit.model?.code}",
                  style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
            ],
          ).onTap(function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderNumberScreen(orderNumber: cubit.model?.code.toString()??""),
              ),
            );
          },),

          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                Text(LocaleKeys.acceptOrder.tr(),
                        style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.whiteColor))
                    .withPadding(bottom: 2.h),
                Text("$time ${LocaleKeys.seconds.tr()}",
                    style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w600, color: AppColors.secondaryColor))
              ],
            ),
          )
        ]),
        Row(
          children: [
            Text(cubit.model?.delivery.toString() ?? "0",
                style: AppTextStyles.textStyle18.copyWith(fontWeight: FontWeight.w700, color: AppColors.blackColor)),
            SvgPicture.asset(AppAssets.sar, width: 24.r, height: 24.r)
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cubit.model?.clint?.name ?? "",
                          style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
                      .withPadding(bottom: 4.h),
                  Text(cubit.model?.clint?.phone ?? "",
                      style: AppTextStyles.textStyle8.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor))
                ],
              ),
            ),
            SvgPicture.asset(AppAssets.call,width: 60.w).onTapShadow(borderRadius: BorderRadius.circular(8.r), function: () async{
              final Uri phoneUri = Uri(scheme: 'tel', path: cubit.model?.clint?.phone);

              if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri);
              } else {

              }
            },)
          ],
        ),

      ],
    ).withPadding(top: 16.h);
  }
}
