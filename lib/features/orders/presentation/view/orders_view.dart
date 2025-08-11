import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/features/orders/presentation/view/widgets/custom_order_item.dart';
import 'package:rakaan/features/orders/presentation/view/widgets/orders_app_bar.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_empty_data.dart';
import '../../../../core/widgets/custom_error.dart';
import '../cubit/orders_cubit.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<OrdersCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrdersAppBar(cubit: cubit, state: state),
              state is OrdersFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData()))
                  : state is OrdersLoading || state is OrdersInitial
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : (state is OrdersSuccess || state is OrdersUpdate) && cubit.orderModel.isEmpty
                          ? Expanded(child: CustomEmptyData(image: AppAssets.noImage, text: "no data"))
                          : Expanded(
                              child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              itemCount: cubit.orderModel.length,
                              itemBuilder: (context, index) => CustomBrokerOrderItem(model: cubit.orderModel[index]).withPadding(top: 16.h),
                            ))
            ],
          ),
        );
      },
    );
  }
}
