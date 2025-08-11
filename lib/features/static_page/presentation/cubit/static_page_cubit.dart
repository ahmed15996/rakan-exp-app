import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';

import '../../data/repository/static_page_repository.dart';

part 'static_page_state.dart';

@injectable
class StaticPageCubit extends Cubit<StaticPageState> {
  StaticPageCubit(this.repository, this.prefs) : super(StaticPageInitial());

  final StaticPageRepository repository;
  final SharedPrefServices prefs;

  String? data;

  void getData({required bool forAbout}) async {
    emit(StaticPagesLoading());
    var result = await repository.getData(forAbout: forAbout);
    result.fold((failure) {
      emit(StaticPagesFailed(msg: failure.message));
    }, (data) {
      this.data = data;
      emit(StaticPagesSuccess());
    });
  }
}
