import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/helpers/enums.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';
import 'package:rakaan/features/order_status/data/param/order_status_param.dart';

import '../../../../core/helpers/image_helper.dart';
import '../../data/repository/order_status_repository.dart';

part 'order_status_state.dart';

@injectable
class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit(this.repository, this.documentHelper) : super(OrderStatusInitial());
  final OrderStatusRepository repository;
  final DocumentHelper documentHelper;
  StatusType type = StatusType.accept;
  String? img;
  bool isUploadImg = false;

  TripModel? model;

  void pickImage({required String id, required StatusType statusType}) async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      img = file.path;
      uploadImg(id: id, statusType: statusType);
      emit(OrderStatusUpdate());
    }
  }

  void changeStatus({required String id, required StatusType statusType}) async {
    emit(OrderStatusLoading());
    var result = await repository.changeStatus(param: OrderStatusParam(statusType: statusType, id: id));
    result.fold(
      (failure) {
        emit(OrderStatusFailed(msg: failure.message));
      },
      (data) {
        model = data;
        img = null;
        isUploadImg = false;
        type = statusType;
        emit(OrderStatusSuccess());
      },
    );
  }

  void uploadImg({required String id, required StatusType statusType}) async {
    emit(UpdateImgLoading());
print(img);
    var result = await repository.uploadImg(
        param: OrderStatusParam(
      statusType: statusType,
      id: id,
          acceptImg: statusType==StatusType.accept?img:null,
          deliverImg: statusType==StatusType.deliver?img:null,
          receiveImg: statusType==StatusType.receive?img:null,
    ));
    result.fold(
      (failure) {
        emit(UpdateImgFailed(msg: failure.message));
      },
      (data) {
        isUploadImg = true;
        emit(UpdateImgSuccess());
      },
    );
  }
}
