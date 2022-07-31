import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import '../services/api_service.dart';
import '../services/service_locator.dart';
import '../utils/sharedPref.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final form = NumberFormat("#,##0.00", "en_US");
  final Api_service _apiservice = locator<Api_service>();
  bool isTouched = false;
  late Future<dynamic> bal;

  @override
  void initState() {
    bal = _apiservice.getBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int num = int.parse(userNum!);
    String? userNum = Prefs.prefs!.getString('user');
    // int num = int.parse(userNum!);
    return Scaffold(
      backgroundColor: const Color(0xffe3ebf2),
      // backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              bal = _apiservice.getBalance();
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 55.0, left: 20, right: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello Chief !',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color(0xff87a9c4),
                              fontWeight: FontWeight.bold,
                              fontSize: 45))),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xff87a9c4),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$userNum',
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: const Color(0xff2b4257),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 90.sp))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('V I S A',
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 90.sp))),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 450.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff87a9c4),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'available balance',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 70.sp)),
                          ),
                          SizedBox(
                            height: 50.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                  future: bal,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: '₦',
                                              style: GoogleFonts.arimo(
                                                textStyle: TextStyle(
                                                    color:
                                                        const Color(0xff2b4257),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 85.sp),
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: isTouched
                                                      ? ' * * * *'
                                                      : form.format(
                                                          snapshot.data!),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff2b4257),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 140.sp),
                                                )
                                              ]));
                                    } else {
                                      return Text(
                                        '₦',
                                        style: GoogleFonts.arimo(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 85.sp),
                                        ),
                                      );
                                    }
                                  }),
                              SizedBox(
                                height: 50.sp,
                              ),
                              Switch(
                                activeTrackColor: Colors.black,
                                activeColor: Colors.white,
                                inactiveTrackColor: Colors.white,
                                value: isTouched,
                                onChanged: (value) {
                                  setState(() {
                                    isTouched = value;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      'services',
                      style: GoogleFonts.alegreyaSans(
                          textStyle: TextStyle(
                              // color: Colors.white,
                              color: const Color(0xff87a9c4),
                              fontWeight: FontWeight.bold,
                              fontSize: 120.sp)),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FinanceCon(
                          titlee: 'assets/images/transfeer.png',
                          firsttitle: 'transfer',
                          ontap: () {
                            Navigator.pushNamed(context, '/transfer');
                          },
                        ),
                        FinanceCon(
                          titlee: 'assets/images/deposit.png',
                          firsttitle: 'deposit',
                          ontap: () {
                            Navigator.pushNamed(context, '/deposit');
                          },

                          // Secondtitle: 'Transfer',
                        ),
                        FinanceCon(
                          titlee: 'assets/images/withdraw.png',
                          firsttitle: 'withdraw',
                          ontap: () {
                            Navigator.pushNamed(context, '/withdraw');
                          },

                          // Secondtitle: 'Transfer',
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'transactions',
                      style: GoogleFonts.alegreyaSans(
                          textStyle: TextStyle(
                              // color: Colors.white,
                              color: const Color(0xff87a9c4),
                              fontWeight: FontWeight.bold,
                              fontSize: 120.sp)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FinanceCon(
                          titlee: 'assets/images/transaction.png',
                          firsttitle: 'all',
                          ontap: () {
                            Navigator.pushNamed(context, '/all');
                          },
                        ),
                        FinanceCon(
                          titlee: 'assets/images/debit.png',
                          firsttitle: 'deposit',
                          ontap: () {
                            Navigator.pushNamed(context, '/credit');
                          },

                          // Secondtitle: 'Transfer',
                        ),
                        FinanceCon(
                          titlee: 'assets/images/credit.png',
                          firsttitle: 'withdraw',
                          ontap: () {
                            Navigator.pushNamed(context, '/debit');
                          },

                          // Secondtitle: 'Transfer',
                        ),
                      ]),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Do you want to exit this App?',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const DueText(text: 'No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const DueText(text: 'Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
