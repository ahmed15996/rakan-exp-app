import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';
import 'package:rakaan/core/models/general_model.dart';
import 'package:rakaan/features/orders/data/param/orders_param.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

import '../../../home/data/models/trip_model.dart';
import '../../data/models/order_model.dart';
import '../../data/repository/orders_repository.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repository, this.prefs) : super(OrdersInitial());
  final OrdersRepository repository;
  final SharedPrefServices prefs;

  List<TripModel> orderModel = [

  ];
  List<GeneralModel> orderTypeList = [
    GeneralModel(id: "asc", title: LocaleKeys.oldest.tr()),
    GeneralModel(id: "desc", title: LocaleKeys.newest.tr()),
  ];
  List<GeneralModel> typeList = [
    GeneralModel(id: "current", title: LocaleKeys.currentOrders.tr()),
    GeneralModel(id: "previous", title: LocaleKeys.previousOrders.tr()),
  ];

  GeneralModel? orderType, type;
  update(){
    getData();
    emit(OrdersUpdate());
  }

  void getData() async {
    emit(OrdersLoading());
    var result = await repository.getData(param: OrdersParam(typeOrder: orderType?.id, type: type?.id));
    result.fold(
      (failure) {
        emit(OrdersFailed(msg: failure.message));
      },
      (data) {
        orderModel=data;

        emit(OrdersSuccess());
      },
    );
  }
}
