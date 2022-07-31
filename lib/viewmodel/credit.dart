import 'package:flutter/cupertino.dart';

import '../model/transaction.dart';
import '../services/api_service.dart';
import '../services/service_locator.dart';

class CreditViewModel extends ChangeNotifier {
  final Api_service _apiservice = locator<Api_service>();
  Future<List<Transaction>> transactions() async {
    List<Transaction> result = await _apiservice.getCredit();
    return result;
  }
}
