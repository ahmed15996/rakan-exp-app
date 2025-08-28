class ApiConstants {
  /// Google Maps
  static const String baseUrlGoogleMaps = 'https://maps.googleapis.com/maps/api';
  static const String placeAutoComplete = '/place/autocomplete/json';
  static const String placeDetails = '/place/details/json';

  /// Api Server
  // static const String baseUrl = 'http://192.99.33.197:8082/api/v1/';
  // static const String baseUrl = 'http://aqarat.somee.com/api/v1/';

  // static const String baseUrl = 'http://sayedabdelkrim-002-site3.qtempurl.com/api/v1/';

  static const String baseUrl = 'https://silver-gaur-258870.hostingersite.com/api/';
  static const String countries = 'country/all';

  static const String cities = 'cities';

  static String neighborhoods(String id) => 'neighberhoods/$id';
  static const String login = 'sign-in';

  static const String register = 'sign-up';
  static const String confirmCode = 'check-otp';
  static const String resendCode = 'send-otp';
  static const String verifyUser = 'users/verify';
  static const String home = 'home';
  static const String updateLocation = 'update-location';
  static const String updateOnline = 'update-online';
  static const String search = 'search';
  static const String addFavorite = 'fav-estate';
  static const String favList = 'user-favourites';
  static const String deleteAllFav = 'delete-all-fav';
  static const String aboutUs = 'about-us';
  static const String terms = 'terms';
  static const String questions = 'questions';
  static const String footer = 'footer';
  static const String orders = 'filter';
  static const String getChats = 'chat-details';
  static const String sendMsg = 'send-message';
  static  String getTrip(String id) => 'order-details/$id';
  static const String toggleNotification = 'user/update-notify';
  static const String logout = 'user/logout';
  static const String deleteAccount = 'user/delete-profile';
  static const String editProfile = 'user/update-profile';
  static const String getCities = 'cities';
  static const String getCars = 'cars';
  static const String onBoarding = 'on-bording';
  static const String deleteNotification = 'read-all-notifications';
  static const String fetchAllNotification = 'notifications';
  static const String readNotification = 'read-all-notifications';
  static const String wallet = 'wallet';
  static const String walletCharging = 'add-balance';
  static const String contact = 'contact-us';
  static const String statics = 'statics';
  static const String accept = 'accept-order';
  static const String receive = 'receive-order';
  static const String deliver = 'deliver-order';
  static const String updateImg = 'update-img';
}
