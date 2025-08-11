enum GoogleMapsCallStatus {
  ok('OK'),
  invalidRequest('INVALID_REQUEST');

  const GoogleMapsCallStatus(this.value);
  final String value;
}