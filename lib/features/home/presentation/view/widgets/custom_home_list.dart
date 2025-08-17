import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart';
import 'package:rakaan/features/home/presentation/view/widgets/custom_home_item.dart';

class CustomHomeList extends StatelessWidget {
  const CustomHomeList({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      children: List.generate(
          cubit.model?.offers?.length ?? 0,
          (index) => CustomHomeItem(
                model: cubit.model!.offers![index],
                time: cubit.model!.seconds?.toInt() ?? 20,
              )),
    ).withPadding(top: 24.h);
  }
}
