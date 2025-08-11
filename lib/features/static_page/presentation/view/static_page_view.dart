import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/custom_error.dart';
import '../../data/arguments/static_page_arguments.dart';
import '../cubit/static_page_cubit.dart';

class StaticPageView extends StatefulWidget {
  const StaticPageView({super.key, required this.argument});

  final StaticPageArguments argument;

  @override
  State<StaticPageView> createState() => _StaticPageViewState();
}

class _StaticPageViewState extends State<StaticPageView> {
  @override
  void initState() {
    super.initState();
    context.read<StaticPageCubit>().getData(forAbout: widget.argument.forAbout);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticPageCubit, StaticPageState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<StaticPageCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: widget.argument.title, widget: cubit.prefs.getData(key: AppCached.token) == null ? SizedBox() : null),
              state is StaticPagesFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData(forAbout: widget.argument.forAbout)))
                  : state is StaticPagesLoading || state is StaticPageInitial
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : Expanded(
                          child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cubit.data ?? "",
                                      style:
                                          AppTextStyles.textStyle14.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayTextColor))
                                  .withPadding(top: 16.h),
                            ],
                          ),
                        ))
            ],
          ),
        );
      },
    );
  }
}
