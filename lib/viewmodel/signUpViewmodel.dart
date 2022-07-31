import 'package:flutter/cupertino.dart';
import 'package:veegilbank/services/api_service.dart';

import '../services/service_locator.dart';
import '../utils/validator.dart';

class RegisterViewModel extends ChangeNotifier {
  final Api_service _apiservice = locator<Api_service>();

  final _phoneNumcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool _passwordVisible = true;

  bool get passwordVisible => _passwordVisible;
  TextEditingController get phoneNumController => _phoneNumcontroller;
  TextEditingController get passwordController => _passwordcontroller;

  String? Function(String? val) get phoneNumValidator =>
      Validators.phoneTextField;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  set passwordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

  Future register() async {
    dynamic result = await _apiservice.singUp(
        phoneNumController.text, passwordController.text);
    return result;
  }
}
