import 'package:injectable/injectable.dart';
import 'package:rakaan/core/constants/app_cached.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';

import '../../../../../../core/errors/exceptions.dart';
import 'auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPrefServices appPref;

  AuthLocalDataSourceImpl({required this.appPref});

  @override
  Future<void> saveDataUser({
    required String token,
    required String id,
    String? accType,
    String? img,
    String? licenseImg,
    String? formImg,
    String? carImg,
    bool? isNotify,
    String? name,
    String? phone,
    String? cityId,
    String? carId,
    String? carName,
    String? email,
    String? cityName,
    String? location,
  }) async {
    try {
      await appPref.saveData(AppCached.token, token);
      await appPref.saveData(AppCached.id, id);
      await appPref.saveData(AppCached.accType, accType);
      await appPref.saveData(AppCached.img, img);
      await appPref.saveData(AppCached.licenseImg, licenseImg);
      await appPref.saveData(AppCached.formImg, formImg);
      await appPref.saveData(AppCached.carImg, carImg);
      await appPref.saveData(AppCached.isNotify,  isNotify);
      await appPref.saveData(AppCached.name,  name);
      await appPref.saveData(AppCached.phone,  phone);
      await appPref.saveData(AppCached.cityId,  cityId);
      await appPref.saveData(AppCached.cityName,  cityName);
      await appPref.saveData(AppCached.location,  location);
      await appPref.saveData(AppCached.carId,  carId);
      await appPref.saveData(AppCached.carName,  carName);
      await appPref.saveData(AppCached.email,  email);
    } catch (error) {
      throw CacheSaveException();
    }
  }
}
