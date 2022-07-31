import 'package:flutter/cupertino.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';
import '../utils/validator.dart';

class LoginViewModel extends ChangeNotifier {
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

  Future login() async {
    dynamic result = await _apiservice.Login(
        phoneNumController.text, passwordController.text);
    // String phoneNumber = result['phoneNumber'];
    // String dataaa = result['data'];
    // String status = result['status'];

    return result;
  }
}
