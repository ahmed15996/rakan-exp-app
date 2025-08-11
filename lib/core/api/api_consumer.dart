
abstract class ApiConsumer {
  Future<dynamic> get(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  });
  Future<dynamic> delete(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  });

  Future<dynamic> post(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  });
  Future<dynamic> put(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  });


}
