import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/faq/presentation/view/widgets/custom_faqs_item.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../../core/constants/app_cached.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_error.dart';
import '../cubit/faq_cubit.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqCubit, FaqState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<FaqCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.faq.tr()),
              state is FaqFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData()))
                  : state is FaqLoading || state is FaqInitial
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : Expanded(
                          child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(cubit.list.length, (index) => CustomFaqsItem(model:cubit.list[index])),
                          ),
                        ))
            ],
          ),
        );
      },
    );
  }
}
