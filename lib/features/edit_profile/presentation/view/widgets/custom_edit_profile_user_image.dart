import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_circle_icon.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../cubit/edit_profile_cubit.dart';

class CustomEditProfileUserImage extends StatelessWidget {
  const CustomEditProfileUserImage({super.key, required this.cubit, required this.state});

  final EditProfileCubit cubit;
  final EditProfileState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
            width: 72.r,
            height: 72.r,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: cubit.image != null
                ? Image.file(File(cubit.image!), width: 72.r, height: 72.r, fit: BoxFit.cover)
                : CustomImageNetwork(image: cubit.savedImg ?? "http", widthImage: 72.r, heightImage: 72.r, fit: BoxFit.cover)),
        CustomRadiusIcon(
            size: 24.r,
            onTap: () {
              cubit.pickImage();
            },
            backgroundColor: AppColors.whiteLightColor,
            child: Icon(Icons.camera_alt_outlined, size: 20.r, color: AppColors.grayTextColor))
      ],
    ).center;
  }
}
