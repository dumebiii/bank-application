import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veegilbank/model/transaction.dart';
import 'package:veegilbank/screen/reusable_widget.dart';
import 'package:veegilbank/viewmodel/allviewmodel.dart';

import 'package:intl/intl.dart';

import '../services/service_locator.dart';

class ALL extends StatefulWidget {
  const ALL({Key? key}) : super(key: key);

  @override
  State<ALL> createState() => _ALLState();
}

class _ALLState extends State<ALL> {
  final form = NumberFormat("#,##0.00", "en_US");
  late Future<List<Transaction>> alltransaction;
  final AllViewModel all = locator<AllViewModel>();
  // final Api_service _apiservice = locator<Api_service>();

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
            title: Text('all transactions',
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
                              // physics: AlwaysScrollableScrollPhysics(),

                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                dynamic money = data[index].amount;
                                DateTime? date = data[index].created;
                                String? type = data[index].type;

                                return TranCon(
                                  // ignore: sort_child_properties_last
                                  child: type == 'credit'
                                      ? Text(
                                          '₦${form.format(money)} has been credited into your account',
                                          style: const TextStyle(fontSize: 19),
                                        )
                                      : Text(
                                          '₦${form.format(money)} has been deducted from your account',
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                  color: type == 'credit'
                                      ? Colors.green
                                      : Colors.red,
                                  date: DateFormat.yMMMEd()

                                      // displaying formatted date

                                      .format(date!),
                                  money: ('₦${form.format(money)}'),
                                );
                              })));
                    }
                  } else if (snapshot.hasError) {
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
