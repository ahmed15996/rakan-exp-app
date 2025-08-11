import 'package:rakaan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinCodeController extends ChangeNotifier {
  final controller = TextEditingController();
  String errorMessage = "";
  PinCodeFieldBorder pinCodeFieldBorder = PinCodeFieldBorder.initial;

  bool validatePinCode() {
    final isPinCodeFieldEmpty = controller.text.isEmpty;
    RegExp regex = RegExp(r'^\d{4}$');

    final isFourNumber = regex.hasMatch(controller.text);

    if (isPinCodeFieldEmpty) {
      errorMessage = LocaleKeys.pinCodeEmpty.tr();
      pinCodeFieldBorder = PinCodeFieldBorder.error;
      notifyListeners();
    } else if (!isFourNumber) {
      errorMessage = LocaleKeys.pinCodeValid.tr();
      pinCodeFieldBorder = PinCodeFieldBorder.error;
      notifyListeners();
    } else {
      disableError();
    }

    if (!isPinCodeFieldEmpty && isFourNumber) {
      return true;
    } else {
      return false;
    }
  }

  disableError() {
    pinCodeFieldBorder = PinCodeFieldBorder.validated;
    errorMessage = "";
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

enum PinCodeFieldBorder { initial, error, validated }
