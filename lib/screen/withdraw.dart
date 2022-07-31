// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:veegilbank/screen/reusable_widget.dart';

import '../services/service_locator.dart';
import '../viewmodel/withdrawViewModel.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final _formKey = GlobalKey<FormState>();
  final WithdrawViewModel withdraw = locator<WithdrawViewModel>();

  @override
  void dispose() {
    withdraw.amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WithdrawViewModel>(
      create: (context) => withdraw,
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
            title: Text('withdraw',
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
                              child: Text('${withdraw.userNum}',
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
                            amountControl: withdraw.amountController,
                            validator: withdraw.amountValidator),
                        SizedBox(
                          height: 50.h,
                        ),
                        Consumer<WithdrawViewModel>(
                            builder: (context, withdraw, child) {
                          return signLogin(
                            todoText: 'withdraw',
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
                                  dynamic result = await withdraw.withdraww();
                                  // ignore: unrelated_type_equality_checks
                                  if (result == 200) {
                                    Navigator.pop(context);
                                    await _showgoodalertdialog(
                                        '${withdraw.amountController.text} naira has been debited from ${withdraw.userNum}  ');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 409) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        'unable to withdraw, balance is low');
                                    Navigator.pop(context);
                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 404) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' User not found  ');

                                    await Navigator.pushReplacementNamed(
                                        context, '/bankHome');
                                  } else if (result == 500) {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' Server is down ');
                                  } else {
                                    Navigator.pop(context);
                                    await _showbadalertdialog(
                                        ' Something went wrong  ');
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
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 50.sp),
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/bankHome', (route) => false),
          width: 200.w,
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
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 50.sp),
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/bankHome', (route) => false),
          width: 200.w,
        )
      ],
    ).show();
  }
}
