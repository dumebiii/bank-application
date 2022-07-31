import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';
import '../utils/sharedPref.dart';
import '../utils/validator.dart';

class DepositViewModel extends ChangeNotifier {
  final Api_service _apiservice = locator<Api_service>();
  var userNum = Prefs.prefs!.getString('user');
  final amountController = TextEditingController();

  String? Function(String? val) get amountValidator =>
      Validators.validateTextField;

  Future deposit() async {
    dynamic result =
        await _apiservice.transfer(userNum!, amountController.text);
    return result;
  }
}
