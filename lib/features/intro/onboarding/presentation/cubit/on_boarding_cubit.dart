import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../data/models/on_boarding_model.dart';
import '../../data/repository/onBoarding_repository.dart';

part 'on_boarding_state.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(this.repository) : super(OnBoardingInitial());
  final OnBoardingRepository repository;

  late int currentIndex = 0;
  List<OnBoardingModel> list = [
    OnBoardingModel(id: 1, title: "title"*5, desc: "desc"*20, image: "https")
  ];
  final pageViewController = PageController();
  bool isLast = false;


  void getData() async {
    emit(OnBoardingLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(OnBoardingFailed(msg: failure.message));
    }, (data) {
      list = data;
      emit(OnBoardingSuccess());
    });
  }

  /// change when call api and put value in success state

  onUpdate({required int index}) {
    if (index < list.length) {
      pageViewController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
      currentIndex = index;

      if (currentIndex == (list.length - 1)) {
        isLast = true;
      }
    }
    emit(OnBoardingUpdateState());
  }

  onSkip() {
    pageViewController.jumpToPage((list.length - 1));
    currentIndex = list.length - 1;


    isLast = true;

    emit(OnBoardingUpdateState());
  }
}
