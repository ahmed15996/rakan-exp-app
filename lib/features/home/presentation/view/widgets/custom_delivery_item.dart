import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/presentation/view/widgets/custom_location_info_item.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../data/models/person_model.dart';

class CustomDeliveryItem extends StatelessWidget {
  const CustomDeliveryItem({super.key, required this.provider, required this.client, this.time, this.img, this.onTap});

  final PersonModel provider, client;
  final String? time;
  final String? img;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLocationInfoItem(
          titleType: LocaleKeys.pickup.tr(),
          name: provider.name ?? "",
          desc: provider.location ?? "",
          distance: "${provider.providerDistance}km",
          withLine: true,
          onTap: onTap,
          img: img,
        ),
        CustomLocationInfoItem(
          titleType: LocaleKeys.delivery.tr(),
          name: client.name ?? "",
          desc: client.location ?? "",
          distance: "${client.clientDistance}Km ",
          withLine: false,
        ).withPadding(bottom: 16.h),
        if (time != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppAssets.clock, width: 12.r, height: 12.r).withPadding(end: 8.w),
              Text(LocaleKeys.scheduledTime.tr(),
                      style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                  .withPadding(end: 4.w),
              Text(time!, style: AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
                  .withPadding(bottom: 4.h),
            ],
          )
      ],
    );
  }
}
