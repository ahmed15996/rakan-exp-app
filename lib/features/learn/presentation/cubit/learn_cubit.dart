import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../data/repository/learn_repository.dart';

part 'learn_state.dart';

@injectable
class LearnCubit extends Cubit<LearnState> {
  LearnCubit(this.repository) : super(LearnInitial());
  final LearnRepository repository;

  String? data;

  void getData() async {
    emit(LearnLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(LearnFailed(msg: failure.message));
    }, (data) {
      this.data = data;
      emit(LearnSuccess());
    });
  }

  void openYouTubeUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
