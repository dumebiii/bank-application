// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import 'package:veegilbank/viewmodel/depositViewModel.dart';

import '../services/service_locator.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final _formKey = GlobalKey<FormState>();

  final DepositViewModel deposit = locator<DepositViewModel>();

  @override
  void dispose() {
    deposit.amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DepositViewModel>(
      create: (context) => deposit,
      child: Scaffold(
        backgroundColor: const Color(0xffe3ebf2),
        appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70))),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('deposit',
                style: GoogleFonts.alegreyaSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 130.sp,
                        fontWeight: FontWeight.w600))),
            centerTitle: true,
            backgroundColor: const Color(0xff87a9c4),
            toolbarHeight: 90),
        body: SafeArea(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 220.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xff87a9c4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text('${deposit.userNum}',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: const Color(0xff2b4257),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 80.sp)))),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        normTextwidg(
                            amountControl: deposit.amountController,
                            validator: deposit.amountValidator),
                        SizedBox(
                          height: 50.h,
                        ),
                        Consumer<DepositViewModel>(
                            builder: (context, deposit, child) {
                          return signLogin(
                            todoText: 'deposit',
                            todo: () async {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())));
                                try {
                                  dynamic result = await deposit.deposit();

                                  if (result == 200) {
                                    Navigator.pop(context);
                                    await _showgoodalertdialog(
                                        '${deposit.amountController.text} naira has been credited to ${deposit.userNum}  ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 409) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' money didn\'t  deposit to ${deposit.userNum}  ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 404) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' User not found ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 500) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' Server is down ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' Something went wrong  ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  }
                                } catch (e) {
                                  debugPrint('$e');
                                }
                              }
                            },
                          );
                        }),
                      ]))),
        )),
      ),
    );
  }

  _showbadalertdialog(String errorMsg) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "An error occured",
      desc: errorMsg,
      buttons: [
        DialogButton(
          color: const Color(0xff345e7d),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/bankHome', (route) => false),
          width: 200.w,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 50.sp),
          ),
        )
      ],
    ).show();
  }

  _showgoodalertdialog(String errorMsg) {
    return Alert(
      context: context,
      type: AlertType.success,
      title: "Great",
      desc: errorMsg,
      buttons: [
        DialogButton(
          color: const Color(0xff345e7d),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/bankHome', (route) => false),
          width: 200.w,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 50.sp),
          ),
        )
      ],
    ).show();
  }
}
