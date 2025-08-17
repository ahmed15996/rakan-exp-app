import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/util/routing/routes.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/features/order_status/data/arguments/order_status_arguments.dart';
import 'package:rakaan/features/trip_details/data/arguments/trip_details_arguments.dart';
import 'package:rakaan/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:rakaan/features/trip_details/presentation/view/widgets/custom_trip_header.dart';
import 'package:rakaan/features/trip_details/presentation/view/widgets/open_img.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../home/presentation/view/widgets/custom_delivery_item.dart';

class TripDetailsView extends StatefulWidget {
  const TripDetailsView({super.key, required this.arguments});

  final TripDetailsArguments arguments;

  @override
  State<TripDetailsView> createState() => _TripDetailsViewState();
}

class _TripDetailsViewState extends State<TripDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<TripDetailsCubit>().getTrip(id: widget.arguments.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TripDetailsCubit, TripDetailsState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<TripDetailsCubit>(context);

          return Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: cubit.currentLocation ?? cubit.defaultLocation,
                      zoom: 13,
                    ),
                    onCameraMove: (cameraPos) {
                      if (cubit.currentLocation != cameraPos.target) {
                        // cubit.onUpdateCamera(position: cameraPos);
                      }
                    },
                    // onTap: (position) {
                    //   cubit.onUpdateCamera(position: CameraPosition(target: position));
                    // },
                    onMapCreated: cubit.onMapCreate,
                    fortyFiveDegreeImageryEnabled: false,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    compassEnabled: false,
                    polylines: cubit.polyLines,
                  )),
              state is TripDetailsFailed
                  ? SizedBox(
                height: 500.h,
                child: CustomError(error: state.msg, retry: () => cubit.getTrip(id: widget.arguments.id))
                    .withPadding(vertical: 48.h, top: 40.h),
              )
                  : state is TripDetailsLoading || state is TripDetailsInitial
                  ? SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor))
                  .withPadding(vertical: 48.h, top: 40.h)
                  .center
                  :
              Column(
                children: [
                  Expanded(
                    child: DraggableScrollableSheet(
                      initialChildSize: cubit.heightSheet, // الحجم الابتدائي
                      minChildSize: 0.3,
                      maxChildSize: .9,
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [BoxShadow(color: AppColors.graySemiBoldColor, blurRadius: 10)],
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                            child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.close, color: AppColors.transparentColor, size: 22.r),
                                              Container(
                                                  width: 90.w,
                                                  height: 2.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.blackColor, borderRadius: BorderRadius.circular(24.r))),
                                              Icon(Icons.close, color: AppColors.blackColor, size: 22.r).onTapShadow(
                                                borderRadius: BorderRadius.circular(8.r),
                                                function: () => context.pop(),
                                              )
                                            ],
                                          ),
                                          CustomTripHeader(cubit: cubit, time: widget.arguments.second),
                                          Divider(height: 32.h, color: AppColors.whiteLightColor, thickness: 10.h),
                                          if (cubit.model != null)
                                            CustomDeliveryItem(
                                              provider: cubit.model!.serviceProvider!,
                                              client: cubit.model!.clint!,
                                              time: cubit.model?.time ?? "",
                                              img: AppAssets.market,
                                              onTap: () {
                                                if (cubit.model!.serviceProvider!.img != null) {
                                                  Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder: (_, __, ___) =>
                                                          FullScreenImageView(imageUrl: cubit.model!.serviceProvider!.img!),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          Divider(height: 32.h, color: AppColors.whiteLightColor, thickness: 10.h),
                                          Row(children: [
                                            SvgPicture.asset(AppAssets.money, width: 16.r, height: 16.r).withPadding(end: 4.w),
                                            Text(LocaleKeys.orderCostAndDelivery.tr(),
                                                    style: AppTextStyles.textStyle12
                                                        .copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                                                .withPadding(end: 8.w),
                                            Text((cubit.model?.total ?? "0") + LocaleKeys.currencySar.tr(),
                                                style: AppTextStyles.textStyle12
                                                    .copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
                                          ]).withPadding(bottom: 12.h),
                                          Row(children: [
                                            SvgPicture.asset(AppAssets.money, width: 16.r, height: 16.r).withPadding(end: 4.w),
                                            Text(LocaleKeys.paymentMethod.tr(),
                                                    style: AppTextStyles.textStyle12
                                                        .copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                                                .withPadding(end: 8.w),
                                            Text(cubit.model?.payment?.name ?? "",
                                                style: AppTextStyles.textStyle12
                                                    .copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor)),
                                          ]),
                                          Divider(height: 32.h, color: AppColors.whiteLightColor, thickness: 10.h),
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                                            decoration:
                                                BoxDecoration(color: AppColors.greyLightColor, borderRadius: BorderRadius.circular(24.r)),
                                            child: Column(
                                              children: [
                                                Image.asset(AppAssets.mapImg, height: 148.h, width: double.infinity, fit: BoxFit.fill),
                                                Text(LocaleKeys.map_desc.tr(),
                                                        style: AppTextStyles.textStyle10
                                                            .copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                                                    .withPadding(vertical: 4.h)
                                              ],
                                            ),
                                          ).onTapShadow(borderRadius: BorderRadius.circular(8.r), function: () => cubit.updateHeight()),
                                          CustomButton(
                                            text: LocaleKeys.deliveryStarted.tr(),
                                            onPressed: () {
                                              if (cubit.model != null) {
                                                context.pushWithNamed(Routes.orderStatusView,
                                                    arguments: OrderStatusArguments(model: cubit.model!));
                                              }
                                            },
                                          ).withPadding(vertical: 16.h, horizontal: 32.w)
                                        ],
                                      ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
