import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';

import '../../../../../core/widgets/custom_toast.dart';
import '../../data/models/wallet_model.dart';
import '../../data/param/wallet_param.dart';
import '../../data/repository/wallet_repository.dart';

part 'wallet_state.dart';

@injectable
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this.repository, this.pref) : super(WalletInitial());
  final WalletRepository repository;
  final SharedPrefServices pref;

  List<WalletModel> list = [];
  String? myBalance;
  final formKey = GlobalKey<FormState>();
  final balance = TextEditingController();
  bool forCharge = false;

  update() {
    forCharge = true;
    emit(WalletUpdate());
  }

  void getData() async {
    emit(WalletLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(WalletFailed(msg: failure.message));
    }, (data) {
      list = data.$1;
      myBalance = data.$2;

      emit(WalletSuccess());
    });
  }

  void charge({required WalletParam param}) async {
    emit(WalletChargingLoading());
    var result = await repository.charge(param: param);
    result.fold((failure) {
      emit(WalletChargingFailed(msg: failure.message));
    }, (msg) {
      emit(WalletChargingSuccess());
    });
  }
}
