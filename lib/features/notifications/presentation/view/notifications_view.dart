import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/core/widgets/custom_error.dart';
import 'package:rakaan/features/notifications/data/models/notification_model.dart';
import 'package:rakaan/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:rakaan/features/notifications/presentation/view/widgets/custom_notification_item.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../../core/widgets/custom_empty_data.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<NotificationsCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                  title: LocaleKeys.notifications.tr(),
                  widget: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.redColor,
                    size: 20.r,
                  ).onTapShadow(
                    borderRadius: BorderRadius.circular(8.r),
                    function: () {
                      cubit.deleteData();
                    },
                  )),
              state is NotificationsFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: cubit.getData))
                  : state is NotificationsLoading
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : cubit.list.isEmpty && state is! NotificationsLoading && state is! NotificationsInitial
                          ? Expanded(
                              child: CustomEmptyData(
                              image: AppAssets.notifications,
                              text: LocaleKeys.notifications.tr(),
                            ))
                          : Expanded(
                              child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child: Column(
                                spacing: 8.h,
                                children: List.generate(
                                    state is NotificationsLoading || state is NotificationsInitial ? 5 : cubit.list.length,
                                    (index) => CustomNotificationItem(
                                          model: state is NotificationsLoading || state is NotificationsInitial
                                              ? NotificationModel(
                                                  id: "id",
                                                  title: "لديك طلب توصيل جديد",
                                                  message: "لديك طلب توصيل جديد",
                                                  image: AppAssets.test,
                                                  createdAt: "9.56 AM")
                                              : cubit.list[index],
                                        )),
                              ),
                            ))
            ],
          ),
        );
      },
    );
  }
}
