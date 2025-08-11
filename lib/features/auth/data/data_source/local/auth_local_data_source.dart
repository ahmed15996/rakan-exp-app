abstract class AuthLocalDataSource {
  Future<void> saveDataUser({
    required String token,
    required String id,
     String? name,
     String? phone,
    String? accType,
    String? location,
    String? cityId,
    String? carId,
    String? carName,
    String? licenseImg,
    String? formImg,
    String? carImg,
    String? cityName,
    String? img,
    String? email,
    bool? isNotify,
  });
}
