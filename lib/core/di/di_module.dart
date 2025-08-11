import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnection get internetConnection => InternetConnection();

  Dio get dioClient => Dio();

  ImagePicker get imagePicker => ImagePicker();
}
