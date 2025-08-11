import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  static phoneValidator(value, countryCode) async {
    return () async {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyPhone.tr();
      }
      final isValid = await PhoneService.parsePhoneNumber(value, countryCode);
      if (!isValid!) {
        return LocaleKeys.validatePhone.tr();
      }
      return null;
    };
  }

  static passwordValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyPassword.tr();
      }
      if (value.length < 8) {
        return LocaleKeys.passwordTooShort.tr();
      }
      return null;
    };
  }

  static validateConfirmPassword(String? password, String? confirmPass) {
    if (confirmPass == null || confirmPass.isEmpty) {
      return LocaleKeys.emptyConfirmPassword.tr();
    } else if (confirmPass != password) {
      return LocaleKeys.passwordsDoNotMatch.tr();
    }
    return null;
  }
  // static durationNumberValidator() {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.durationRequired.tr();
  //     }
  //
  //     return null;
  //   };
  // }
  // static minPriceValidator({
  //   required String maxPrice,
  // }) {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.minPriceRequired.tr();
  //     }
  //     if (maxPrice.isNotEmpty && int.parse(value) > int.parse(maxPrice)) {
  //       return LocaleKeys.minPriceLessThanMax.tr();
  //     }
  //     return null;
  //   };
  // }

//   static maxPriceValidator({
//     required String minPrice,
//   }) {
//     return (value) {
//       if (value == null || value.isEmpty) {
//         return LocaleKeys.maxPriceRequired.tr();
//       }
//       if (minPrice.isNotEmpty && int.parse(value) < int.parse(minPrice)) {
//         return LocaleKeys.maxPriceGreaterThanMin.tr();
//       }
//       return null;
//     };
//   }
// static adPublishDate() {
//     return (value) {
//       if (value == null || value.isEmpty) {
//         return LocaleKeys.adPublishDateRequired.tr();
//       }
//       try {
//         final date = DateTime.parse(value);
//         if (date.isBefore(DateTime.now())) {
//           return LocaleKeys.adPublishDateInvalid.tr();
//         }
//       } catch (e) {
//         return LocaleKeys.invalidDateFormat.tr();
//       }
//       return null;
//     };
//   }
  static fullEmailValidator() {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    return (String? value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyEmail.tr();
      }

      if (!emailRegex.hasMatch(value)) {
        return LocaleKeys.validEmail.tr();
      }

      return null;
    };
  }

  static emailValidator() {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    return (String? value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (!emailRegex.hasMatch(value)) {
        return LocaleKeys.validEmail.tr();
      }
      return null;
    };
  }
  static nameValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyName.tr();
      }
      return null;
    };
  }
  static requiredValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.requiredField.tr();
      }
      return null;
    };
  }

  static firstNameValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyFirstName.tr();
      }
      return null;
    };
  }

  static lastNameValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.emptyLastName.tr();
      }
      return null;
    };
  }

  // static typeMessageValidator() {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.emptyTypeMessage.tr();
  //     }
  //     return null;
  //   };
  // }
  //
  // static messageValidator() {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.emptyYourMessage.tr();
  //     }
  //     return null;
  //   };
  // }
  // static priceValidator() {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return LocaleKeys.enterPrice.tr();
  //     }
  //     return null;
  //   };
  // }

// static nameShopValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyShopName.tr();
//     }
//     return null;
//   };
// }
//
// static otpValidator() {
//   return (value) {
//     RegExp regex = RegExp(r'^\d{4}$');
//
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.pinCodeEmpty.tr();
//     } else if (!regex.hasMatch(value)) {
//       return LocaleKeys.pinCodeValid.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownCityValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyCity.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownBrandValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyBrand.tr();
//     }
//     return null;
//   };
// }
//
// static descPieceValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyDescPiece.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownWidthValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyWidth.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownHeightValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyHeight.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownRimValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyRim.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownBankValidator() {
//   return (CityOrBrandOrBankModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyBankName.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownServiceValidator() {
//   return (ServiceModel? value) {
//     if (value == null || value.name.isEmpty) {
//       return LocaleKeys.emptyService.tr();
//     }
//     return null;
//   };
// }
//
// static dropDownBrandsValidator() {
//   return (List<CityOrBrandOrBankModel>? values) {
//     if (values == null || values.isEmpty) {
//       return LocaleKeys.emptyBrandsName.tr();
//     }
//     return null;
//   };
// }
//
// static locationValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyLocation.tr();
//     }
//     return null;
//   };
// }
//


//
// static accNumberValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyBankNum.tr();
//     }
//     return null;
//   };
// }
//
// static ibanNumValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyIbanNum.tr();
//     }
//     return null;
//   };
// }
//
// static taxNumValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyTaxNum.tr();
//     }
//     return null;
//   };
// }
//
// static commerceNumberValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyNumCommerce.tr();
//     }
//     return null;
//   };
// }
//
// static commerceImageValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyAttachImageCommerce.tr();
//     }
//     return null;
//   };
// }
//
// static priceInstallationValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyPriceInstallation.tr();
//     }
//     return null;
//   };
// }
//
// static priceWeightValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyPriceWeight.tr();
//     }
//     return null;
//   };
// }
//
// static priceFullWeightValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyPriceFullWeight.tr();
//     }
//     return null;
//   };
// }
//
// static newPriceOfferValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyOfferNewPrice.tr();
//     }
//     return null;
//   };
// }
//
// static offerDescValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyOfferDesc.tr();
//     }
//     return null;
//   };
// }
//
// static offerDurationValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyOfferDuration.tr();
//     }
//     return null;
//   };
// }
//
// static offerPriceValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyOfferPrice.tr();
//     }
//     return null;
//   };
// }
//
// static problemValidator() {
//   return (value) {
//     if (value == null || value.isEmpty) {
//       return LocaleKeys.emptyProblem.tr();
//     }
//     return null;
//   };
// }
}
