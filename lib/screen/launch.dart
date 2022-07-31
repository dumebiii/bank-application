import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3ebf2),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text('',
              //     style: TextStyle(

              //         fontSize: 150.sp,
              //         fontFamily: 'Inter',
              //         fontWeight: FontWeight.w800)),
              Text('Veegil Bank',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xff345e7d),
                          fontWeight: FontWeight.bold,
                          fontSize: 50))),
              SizedBox(
                height: 30.h,
              ),
              Text('better ideas, better banking...',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xff345e7d),
                          fontWeight: FontWeight.w400,
                          fontSize: 19))),
              SizedBox(
                height: 250.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signUp');
                },
                child: CircleAvatar(
                    radius: 140.r,
                    backgroundColor: const Color(0xff345e7d),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 120.r,
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 60),
              //   child: Container(
              //     height: 150.h,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(25)),
              //     child: TextButton(
              //       onPressed: () {
              //         Navigator.pushReplacementNamed(context, '/signUp');
              //       },
              //       child: Text(
              //         'Sign Up ',
              //         style: TextStyle(
              //           fontSize: 70.sp,
              //           fontWeight: FontWeight.w600,
              //           color: const Color(0xff3071E7),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 50.w),
              //       child: Container(
              //           height: 50,
              //           width: 98,
              //           child: Center(
              //             child: const Text('Log In ',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600,
              //                     color: Color(0xff3071E7))),
              //           ),
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(25))),
              //     ),
              //     // SizedBox(
              //     //   width: 5,
              //     // ),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 50.w),
              //       child: Container(
              //           width: 98,
              //           height: 50,
              //           child: Center(
              //             child: const Text('Sign Up ',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600,
              //                     color: Color(0xff3071E7))),
              //           ),
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(25))),
              //     ),
              //   ],
              //)
            ],
          ),
        ),
      )),
    );
  }
}
