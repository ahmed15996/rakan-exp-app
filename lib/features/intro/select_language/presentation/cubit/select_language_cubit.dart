import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/routing/routes.dart';

part 'select_language_state.dart';

@injectable
class SelectLanguageCubit extends Cubit<SelectLanguageState> {
  final SharedPrefServices appPref;

  SelectLanguageCubit(this.appPref) : super(SelectLanguageInitial());

  void saveChanges(BuildContext context, int index) async {
    if (index == 0) {
      await context.setLocale(const Locale('ar'));
      await appPref.saveData(AppCached.lang, 'ar');
      context.pushWithNamed(Routes.onBoardingView);
    } else {
      await context.setLocale(const Locale('en'));
      await appPref.saveData(AppCached.lang, 'en');
      context.pushWithNamed(Routes.onBoardingView);
    }
  }
}
