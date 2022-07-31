import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veegilbank/screen/alltransaction.dart';
import 'package:veegilbank/screen/credit.dart';
import 'package:veegilbank/screen/deposit.dart';
import 'package:veegilbank/screen/homePage.dart';
import 'package:veegilbank/screen/login.dart';
import 'package:veegilbank/screen/transfer.dart';
import 'package:veegilbank/screen/withdraw.dart';

import 'screen/debit.dart';
import 'screen/launch.dart';
import 'screen/signUp.dart';
import 'services/service_locator.dart';
import 'utils/sharedPref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpserviceLocator();
  await Prefs.init();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(1440, 3040),
      builder: (_, child) => MaterialApp(
          theme: ThemeData(
            primaryColor: Colors
                .white, //here it goes try changing this to your preferred colour
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/redirect',
          routes: {
            '/launch': (context) => const Launch(),
            '/transfer': (context) => const Transfer(),
            '/deposit': (context) => const Deposit(),
            '/withdraw': (context) => const Withdraw(),
            '/login': (context) => const LoginScreen(),
            '/signUp': (context) => const SignUP(),
            '/bankHome': (context) => const HomePage(),
            '/all': (context) => const ALL(),
            '/debit': (context) => const Debit(),
            '/credit': (context) => const Credit(),
            '/redirect': (context) => const Redirect(),
          }),
    );
  }
}

class Redirect extends StatefulWidget {
  const Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  var token = Prefs.prefs!.getString('token');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: token == null ? const Launch() : const HomePage(),
    );
  }
}
