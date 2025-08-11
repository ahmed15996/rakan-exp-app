class PlaceLatLngModel {
  final double latitude;
  final double longitude;

  PlaceLatLngModel({
    required this.latitude,
    required this.longitude,
  });

  factory PlaceLatLngModel.fromJson(Map<String, dynamic> jsonData) {
    return PlaceLatLngModel(
      latitude: jsonData['lat'] ?? jsonData['latitude'],
      longitude: jsonData['lng'] ?? jsonData['longitude'],
    );
  }
}
