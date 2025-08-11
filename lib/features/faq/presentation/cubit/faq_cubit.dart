import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';

import '../../data/models/faq_model.dart';
import '../../data/repository/faq_repository.dart';

part 'faq_state.dart';

@injectable
class FaqCubit extends Cubit<FaqState> {
  FaqCubit(this.repository) : super(FaqInitial());
  final FaqRepository repository;


  List<FaqModel> list = [];

  void getData() async {
    emit(FaqLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(FaqFailed(msg: failure.message));
    }, (data) {
      list = data;
      emit(FaqSuccess());
    });
  }
}
