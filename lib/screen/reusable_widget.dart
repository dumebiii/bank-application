import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class signLogin extends StatelessWidget {
  const signLogin({
    Key? key,
    required this.todoText,
    required this.todo,
  }) : super(key: key);
  final String todoText;
  final VoidCallback todo;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xff345e7d),
          // border: Border.all(
          //   color: Colors.blue,
          // ),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: todo,
        child: Text(
          todoText,
          style: TextStyle(
            fontSize: 80.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class passwordWidg extends StatelessWidget {
  const passwordWidg({
    Key? key,
    required this.onpressed,
    required this.passwordVisible,
    required this.passwordControl,
    required this.validator,
  }) : super(key: key);

  final TextEditingController passwordControl;
  final String? Function(String?) validator;
  final bool passwordVisible;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: passwordControl,
        cursorHeight: 20,
        style: const TextStyle(fontSize: 22),
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        obscureText: passwordVisible,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(8),
          suffix: TextButton(
            onPressed: onpressed,
            child: passwordVisible
                ? const Text('Show',
                    style: TextStyle(fontSize: 20, color: Colors.white))
                : const Text('Hide',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          // onPressed: () {
          //   passwordVisible = !passwordVisible;
          // }),
          filled: true,
          hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
          hintText: "password",
          fillColor: const Color(0xff87a9c4),
        ));
  }
}

class numWidget extends StatelessWidget {
  const numWidget({
    Key? key,
    required this.phoneNumControl,
    required this.validator,
  }) : super(key: key);

  final TextEditingController phoneNumControl;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: phoneNumControl,
        cursorColor: Colors.white,
        cursorHeight: 20,
        style: const TextStyle(fontSize: 22),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
            hintText: "phone number",
            fillColor: const Color(0xff87a9c4),
            filled: true));
  }
}

class normTextwidg extends StatelessWidget {
  const normTextwidg({
    Key? key,
    required this.amountControl,
    required this.validator,
  }) : super(key: key);
  final TextEditingController amountControl;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: amountControl,
        cursorColor: Colors.white,
        cursorHeight: 20,
        style: const TextStyle(fontSize: 22),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          filled: true,
          hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
          hintText: "amount",
          fillColor: const Color(0xff87a9c4),
        ));
  }
}

class FinanceCon extends StatelessWidget {
  final String firsttitle;
  final String? titlee;

  const FinanceCon({
    // ignore: non_constant_identifier_names
    Key? key,
    required this.firsttitle,
    required this.ontap,
    this.titlee,
  }) : super(key: key);

  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 400.h,
        width: 400.w,
        decoration: BoxDecoration(
            color: const Color(0xff87a9c4),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              titlee!,
              scale: 1.5,
            ),
            SizedBox(
              height: 30.sp,
            ),
            Text(
              firsttitle,
              softWrap: true,
              maxLines: 2,
              style: GoogleFonts.alegreyaSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 75.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TranCon extends StatelessWidget {
  final String money;
  final String date;
  final Color color;
  final Widget child;
  const TranCon({
    Key? key,
    required this.child,
    required this.money,
    required this.date,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 110,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, bottom: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      )),
                  Text(
                    money,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: color),
                  ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class DueText extends StatelessWidget {
  const DueText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      style: TextStyle(
          color: const Color(0xff2b4257),
          fontSize: 70.sp,
          fontWeight: FontWeight.w500),
    );
  }
}
