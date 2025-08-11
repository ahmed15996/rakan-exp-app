import 'dart:io';

class VerifyUserParam {

  final String? countryCode , phoneNumber , valLicenseNumber , absherMobileNumber , titleDeedNumber , idNumber;
  final int accountType;


  final List<File> documents;

  VerifyUserParam({
    required this.countryCode,
    required this.phoneNumber,
    required this.accountType,
    required this.valLicenseNumber,
    required this.absherMobileNumber,
    required this.titleDeedNumber,
    required this.idNumber,
    required this.documents,
  });

}
