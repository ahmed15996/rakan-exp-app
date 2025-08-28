import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';

import '../../../../../../../core/util/routing/routes.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SharedPrefServices appPref;

  SplashCubit(this.appPref) : super(SplashInitial());

  void handlePageNext({required BuildContext context}) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        String lang = appPref.getData(key: AppCached.lang) ?? "";
        String token = appPref.getData(key: AppCached.token) ?? "";
        if (token.isNotEmpty) {
          if (context.mounted) {
            context.pushAndRemoveUntilWithNamed(Routes.homeView);
          }
        } else if (lang.isEmpty) {
          if (context.mounted) {
            context.pushAndRemoveUntilWithNamed(Routes.selectLanguageView);
          }
        } else {
          if (context.mounted && !((appPref.getData(key: AppCached.isFirstLogin) ?? false))) {
            context.pushAndRemoveUntilWithNamed(Routes.onBoardingView);
          } else {
            context.pushAndRemoveUntilWithNamed(Routes.loginView);
          }
        }
      },
    );
  }
}
