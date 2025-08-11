import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_empty_data.dart';
import 'package:rakaan/features/home/presentation/cubit/home_cubit.dart';
import 'package:rakaan/features/home/presentation/view/widgets/custom_home_app_bar.dart';
import 'package:rakaan/features/home/presentation/view/widgets/custom_home_list.dart';
import 'package:rakaan/features/home/presentation/view/widgets/custom_search_for_orders.dart';

import '../../../side_menu/presentation/view/custom_side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          drawer: CustomSideMenu(),
          drawerEnableOpenDragGesture: true,
          onDrawerChanged: (isOpened) {
            cubit.update();
          },
          body: Stack(
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
                  )),
              Column(
                children: [
                  CustomHomeAppBar(cubit: cubit, state: state),
                  Expanded(
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.32, // الحجم الابتدائي
                      minChildSize: 0.32,
                      maxChildSize: 0.95,
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
                                Container(
                                        width: 90.w,
                                        height: 2.h,
                                        decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(24.r)))
                                    .center,
                                if (state is UpdateLocationFailed)
                                  SizedBox(
                                      height: 200.h,
                                      child: Icon(Icons.refresh, size: 80.r, color: AppColors.hintColor)
                                          .onTapShadow(borderRadius: BorderRadius.circular(8.r), function: ()async {
                                     await   cubit.checkPermission();
                                      })),
                                if (cubit.haveTrip && (cubit.model?.offers.isNotEmpty ?? false)) CustomHomeList(cubit: cubit),
                                if (cubit.haveTrip && (cubit.model?.offers.isEmpty ?? false))
                                  CustomEmptyData(image: AppAssets.notifications, text: "empty data"),
                                if (!cubit.haveTrip && state is! UpdateLocationFailed) CustomSearchForOrders()
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
          ),
        );
      },
    );
  }
}
