import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeviceInfo {
  static final info = DeviceInfoPlugin();
  static IosDeviceInfo? iosInfo;
  static AndroidDeviceInfo? androidInfo;

  Future<void> init() async {
    if (Platform.isIOS) {
      iosInfo = await info.iosInfo;
    } else {
      androidInfo = await info.androidInfo;
    }
  }

  String get id {
    try {
      if (Platform.isIOS) {
        return iosInfo!.localizedModel;
      } else {
        return androidInfo!.id;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
