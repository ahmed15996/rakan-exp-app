import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/features/side_menu/data/repository/settings_repository.dart';

import '../../../../core/local/shared_preferences/shared_pref_services.dart';
import '../../../../core/util/routing/routes.dart';
import '../../../auth/data/models/user_model.dart';

part 'side_menu_state.dart';

@injectable
class SideMenuCubit extends Cubit<SideMenuState> {
  SideMenuCubit(this.repository, this.pref) : super(SideMenuInitial());
  final SettingsRepository repository;
  final SharedPrefServices pref;

  late UserModel model;
  String? avatarAsset;

  update() {
    emit(SideMenuUpdate());
  }

  void logout({required BuildContext context}) async {
    emit(LogoutLoading());
    var result = await repository.logout();
    result.fold((failure) {
      emit(LogoutFailed(msg: failure.message));
    }, (msg) async {
      await pref.removeData(key: AppCached.token);
      await pref.removeData(key: AppCached.cityId);
      await pref.removeData(key: AppCached.cityName);
      await pref.removeData(key: AppCached.carId);
      await pref.removeData(key: AppCached.carName);
      await pref.removeData(key: AppCached.carImg);
      await pref.removeData(key: AppCached.name);
      await pref.removeData(key: AppCached.phone);
      await pref.removeData(key: AppCached.isNotify);

      context.pushAndRemoveUntilWithNamed(Routes.loginView);
      emit(LogoutSuccess(msg: msg));
    });
  }

  /// delete profile
  void deleteAccount({required BuildContext context}) async {
    emit(DeleteAccountLoading());
    var result = await repository.deleteAccount();
    result.fold((failure) {
      emit(DeleteAccountFailed(msg: failure.message));
    }, (msg) async {
      await pref.removeData(key: AppCached.token);
      await pref.removeData(key: AppCached.cityId);
      await pref.removeData(key: AppCached.cityName);
      await pref.removeData(key: AppCached.carId);
      await pref.removeData(key: AppCached.carName);
      await pref.removeData(key: AppCached.carImg);
      await pref.removeData(key: AppCached.name);
      await pref.removeData(key: AppCached.phone);
      await pref.removeData(key: AppCached.isFirstLogin);
      await pref.removeData(key: AppCached.isNotify);

      context.pushAndRemoveUntilWithNamed(Routes.loginView);
      emit(DeleteAccountSuccess(msg: msg));
    });
  }

  saveLang({required String lang}) async {
    await pref.saveData(AppCached.lang, lang);
    emit(SideMenuUpdate());
  }
}
