// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import 'package:veegilbank/viewmodel/loginViewmodel.dart';

import '../services/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginViewModel login = locator<LoginViewModel>();

  @override
  void dispose() {
    login.passwordController.dispose();
    login.phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => login,
      child: Scaffold(
        backgroundColor: const Color(0xffe3ebf2),
        body: Consumer<LoginViewModel>(builder: (context, login, child) {
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
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: const Color(0xff2b4257),
                              size: 110.sp,
                            )),
                        Text(
                          'Log In',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: const Color(0xff2b4257),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100.sp)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(
                            'Sign up',
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
                      validator: login.phoneNumValidator,
                      phoneNumControl: login.phoneNumController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    passwordWidg(
                      onpressed: (() {
                        login.passwordVisible = !login.passwordVisible;
                      }),
                      validator: login.passwordValidator,
                      passwordVisible: login.passwordVisible,
                      passwordControl: login.passwordController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    signLogin(
                      todoText: 'Log in',
                      todo: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                  child: Center(
                                      child: CircularProgressIndicator())));
                          try {
                            dynamic result = await login.login();

                            if (result == 200) {
                              Navigator.pop(context);

                              Navigator.pushReplacementNamed(
                                  context, '/bankHome');
                            } else if (result == 404) {
                              Navigator.pop(context);
                              _showalertdialog(
                                  'phone number or password is incorrect.');
                            } else if (result == 500) {
                              Navigator.pop(context);
                              await _showalertdialog(' Server is down ');
                            } else {
                              Navigator.pop(context);
                              await _showalertdialog(' Something went wrong  ');
                            }
                            // try {
                            //   Navigator.pushNamed(context, 'launch');
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
