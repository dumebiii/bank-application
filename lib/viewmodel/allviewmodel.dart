import 'package:flutter/cupertino.dart';
import 'package:veegilbank/model/transaction.dart';

import '../services/api_service.dart';
import '../services/service_locator.dart';

class AllViewModel extends ChangeNotifier {
  final Api_service _apiservice = locator<Api_service>();
  Future<List<Transaction>> transactions() async {
    List<Transaction> result = await _apiservice.getTransaction();
    return result;
  }
}
