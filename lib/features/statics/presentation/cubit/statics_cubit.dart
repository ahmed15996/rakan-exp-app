import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/static_model.dart';
import '../../data/repository/statics_repository.dart';

part 'statics_state.dart';

@injectable
class StaticsCubit extends Cubit<StaticsState> {
  StaticsCubit(this.repository) : super(StaticsInitial());
  final StaticsRepository repository;

  StaticValueModel? model;

  void getData() async {
    emit(StaticsLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(StaticsFailed(msg: failure.message));
    }, (data) {
      model = data;
      emit(StaticsSuccess());
    });
  }
}
