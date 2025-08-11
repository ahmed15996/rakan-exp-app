
import 'package:rakaan/core/api/http_search_places.dart';
import 'package:rakaan/core/constants/api_constants.dart';
import 'package:rakaan/core/models/place_lat_long_model.dart';
import 'package:rakaan/core/models/place_model.dart';
import 'package:flutter/foundation.dart';


import 'enum_google_map_call_status.dart';

class GooglePlacesPlus {
  static Future<List<PlaceModel>> getSuggestions({
    required String searchQuery,
    required String googleMapsKey,
  }) async {
    final response = await HttpClient.get(
      ApiConstants.placeAutoComplete,
      queryParameters: {
        'input': searchQuery,
        'radius': 500,
        'key': googleMapsKey,
      },
    );
    if (kDebugMode) {
      print(response);
    }
    if (response['status'] == GoogleMapsCallStatus.ok.value) {
      return List<PlaceModel>.from(
        ((response['predictions'] ?? []) as List).map(
          (place) => PlaceModel.fromJson(place),
        ),
      );
    } else if (response['status'] == GoogleMapsCallStatus.invalidRequest.value) {
      return [];
    } else {
      throw Exception("Couldn't fetch search results");
    }
  }
  static Future<PlaceLatLngModel> getLatitudeAndLongitude({
    required String placeId,
    required String googleMapsKey,
  }) async {
    final response = await HttpClient.get(
      ApiConstants.placeDetails,
      queryParameters: {
        'place_id': placeId,
        'radius': 500,
        'key': googleMapsKey,
      },
    );
    if (kDebugMode) {
      print(response);
    }
    if (response['status'] == GoogleMapsCallStatus.ok.value) {
      return PlaceLatLngModel.fromJson(
        response['result']['geometry']['location'],
      );
    }
    throw Exception("Couldn't fetch search results");
  }
}
