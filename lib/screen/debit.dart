import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import 'package:veegilbank/viewmodel/debit.dart';

import '../model/transaction.dart';
import '../services/service_locator.dart';

class Debit extends StatefulWidget {
  const Debit({Key? key}) : super(key: key);

  @override
  State<Debit> createState() => _DebitState();
}

class _DebitState extends State<Debit> {
  final form = NumberFormat("#,##0.00", "en_US");
  late Future<List<Transaction>> alltransaction;
  final DebitViewModel all = locator<DebitViewModel>();

  @override
  void initState() {
    super.initState();
    alltransaction = all.transactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: FutureBuilder(
                future: alltransaction,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Transaction> data = snapshot.data;

                    if (data.isEmpty) {
                      return const Center(
                          child: Text('No transaction has been made',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )));
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                dynamic money = data[index].amount;
                                DateTime? date = data[index].created;

                                return TranCon(
                                  color: Colors.red,
                                  date: DateFormat.yMMMEd()

                                      // displaying formatted date

                                      .format(date!),
                                  money: ('₦${form.format(money)}'),
                                  child: Text(
                                    '₦${form.format(money)} has been deducted from your account',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                );
                              })));
                    }
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Failed to load transaction!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
