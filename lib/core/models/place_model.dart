class PlaceModel {
  final String id;
  final String name;

  PlaceModel({
    required this.id,
    required this.name,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> jsonData) {
    return PlaceModel(
      id: jsonData['place_id'],
      name: jsonData['description'],
    );
  }
}
