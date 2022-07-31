// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:veegilbank/screen/reusable_widget.dart';

import '../services/service_locator.dart';
import '../viewmodel/signUpViewmodel.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel regist = locator<RegisterViewModel>();
  bool remember = true;

  @override
  void dispose() {
    regist.passwordController.dispose();
    regist.phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => regist,
      child: Scaffold(
        backgroundColor: const Color(0xffe3ebf2),
        body: Consumer<RegisterViewModel>(builder: (context, regist, child) {
          return SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/launch');
                            },
                            icon: Icon(
                              Icons.close,
                              color: const Color(0xff2b4257),
                              size: 110.sp,
                            )),
                        Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: const Color(0xff2b4257),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100.sp)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 70.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff2b4257),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    numWidget(
                      phoneNumControl: regist.phoneNumController,
                      validator: regist.phoneNumValidator,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    passwordWidg(
                      onpressed: (() {
                        regist.passwordVisible = !regist.passwordVisible;
                      }),
                      validator: regist.passwordValidator,
                      passwordVisible: regist.passwordVisible,
                      passwordControl: regist.passwordController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    signLogin(
                      todoText: 'Sign up',
                      todo: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                  child: Center(
                                      child: CircularProgressIndicator())));
                          try {
                            dynamic result = await regist.register();

                            // ignore: unrelated_type_equality_checks
                            if (result == 200) {
                              Navigator.pop(context);

                              Navigator.pushReplacementNamed(context, '/login');
                            } else if (result == 409) {
                              Navigator.pop(context);
                              _showalertdialog(
                                  '${regist.phoneNumController.text} is already registered ');
                            } else if (result == 500) {
                              Navigator.pop(context);
                              await _showalertdialog(' Server is down ');
                            } else {
                              Navigator.pop(context);
                              await _showalertdialog(' Something went wrong  ');
                            }
                          } catch (e) {
                            debugPrint('$e');
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ));
        }),
      ),
    );
  }

  _showalertdialog(String errorMsg) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "An error occured",
      desc: errorMsg,
      buttons: [
        DialogButton(
          color: const Color(0xff345e7d),
          onPressed: () => Navigator.pop(context),
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
