import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/widgets/custom_location_permission_dialog.dart';
import 'package:rakaan/rakaan_app.dart';

class LocationHelper {
  static Future<bool> isServiceEnabled() async {
    bool isServiceEnabled = false;
    bool result = await Geolocator.isLocationServiceEnabled();
    if (result) {
      isServiceEnabled = true;
    }
    return isServiceEnabled;
  }

  static Future<bool> isServiceHavePermission() async {
    bool havePermission = false;
    LocationPermission isServiceEnabled = await Geolocator.checkPermission();
    if (isServiceEnabled == LocationPermission.whileInUse ||
        isServiceEnabled == LocationPermission.always ||
        isServiceEnabled == LocationPermission.unableToDetermine) {
      havePermission = true;
    }
    return havePermission;
  }

  static Future<void> requestLocationPermission({Function()? onFinish}) async {
    var permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Ensure the context is valid before using it
      final context = RakaanApp.appNavigatorKey.currentState!.context;
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (_) => CustomLocationPermissionDialog(
            onFinish: onFinish ?? () {},
          ),
        );
      }
    } else {
      if (onFinish != null) {
        onFinish();
      }
    }
  }

  static Future<Position> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      throw Exception('Failed to get current location. Please check your location settings or try again later');
    }
  }

  static Future<void> openAppIfPermissionDenied({Function()? onFinish}) async {
    final isGranted = await Permission.locationWhenInUse.request().isGranted;
    if (!isGranted) {
      await AppSettings.openAppSettings(type: AppSettingsType.settings);
      final context = RakaanApp.appNavigatorKey.currentState!.context;
      if (context.mounted) {
        context.pop();
      }
      onFinish!();
    }
  }

  static Future<Placemark> getLocationInfo(LatLng position) async =>
      await placemarkFromCoordinates(position.latitude, position.longitude).then((value) {
        Placemark placeMark = value[0];
        return placeMark;
      });
}
