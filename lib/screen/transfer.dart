// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import 'package:veegilbank/viewmodel/transferViewModel.dart';

import '../services/service_locator.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final _formKey = GlobalKey<FormState>();
  final TransferViewModel transf = locator<TransferViewModel>();

  @override
  void dispose() {
    transf.amountController.dispose();
    transf.phoneNumcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransferViewModel>(
        create: (context) => transf,
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
              title: Text('transfer',
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
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          numWidget(
                            phoneNumControl: transf.phoneNumcontroller,
                            validator: transf.phoneNumValidator,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          normTextwidg(
                              amountControl: transf.amountController,
                              validator: transf.amountValidator),
                          SizedBox(
                            height: 50.h,
                          ),
                          Consumer<TransferViewModel>(
                              builder: (context, transf, child) {
                            return signLogin(
                              todoText: 'transfer',
                              todo: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context) => const Center(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator())));
                                  try {
                                    dynamic result = await transf.transferr();
                                    // ignore: unrelated_type_equality_checks
                                    if (result == 200) {
                                      Navigator.pop(context);
                                      await _showgoodalertdialog(
                                          '${transf.amountController.text} naira has been sent to ${transf.phoneNumcontroller.text}  ');
                                      Navigator.pop(context);
                                      await Navigator.pushReplacementNamed(
                                          context, '/bankHome');
                                    } else if (result == 409) {
                                      Navigator.pop(context);

                                      await _showbadalertdialog(
                                          ' money didn\'t send to ${transf.phoneNumcontroller.text}  ');
                                      Navigator.pop(context);
                                      await Navigator.pushReplacementNamed(
                                          context, '/bankHome');
                                    } else if (result == 404) {
                                      Navigator.pop(context);
                                      await _showbadalertdialog(
                                          ' User(${transf.phoneNumcontroller}) not found  ');
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
        ));
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
