import 'package:flutter/cupertino.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';
import '../utils/validator.dart';

class TransferViewModel extends ChangeNotifier {
  final Api_service _apiservice = locator<Api_service>();
  final phoneNumcontroller = TextEditingController();

  final amountController = TextEditingController();
  String? Function(String? val) get phoneNumValidator =>
      Validators.phoneTextField;

  String? Function(String? val) get amountValidator =>
      Validators.validateTextField;

  Future transferr() async {
    dynamic result = await _apiservice.transfer(
        phoneNumcontroller.text, amountController.text);

    return result;
  }
}
