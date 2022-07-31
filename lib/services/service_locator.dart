import 'package:get_it/get_it.dart';
import 'package:veegilbank/viewmodel/allviewmodel.dart';
import 'package:veegilbank/viewmodel/depositViewModel.dart';
import 'package:veegilbank/viewmodel/transferViewModel.dart';
import 'package:veegilbank/viewmodel/withdrawViewModel.dart';

import '../viewmodel/credit.dart';
import '../viewmodel/debit.dart';
import '../viewmodel/loginViewmodel.dart';
import '../viewmodel/signUpViewmodel.dart';
import 'api_service.dart';

GetIt locator = GetIt.instance;

Future<void> setUpserviceLocator() async {
  locator.registerSingleton<Api_service>(Api_service());
  // locator.registerSingleton<NotesOpertaion>(NotesOpertaion());

  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<TransferViewModel>(() => TransferViewModel());
  locator.registerFactory<DepositViewModel>(() => DepositViewModel());
  locator.registerFactory<WithdrawViewModel>(() => WithdrawViewModel());
  locator.registerFactory<AllViewModel>(() => AllViewModel());
  locator.registerFactory<CreditViewModel>(() => CreditViewModel());
  locator.registerFactory<DebitViewModel>(() => DebitViewModel());
}
