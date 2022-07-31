import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:veegilbank/model/transaction.dart';
import 'package:veegilbank/model/users.dart';
import 'package:veegilbank/services/constants.dart';
import 'package:veegilbank/utils/sharedPref.dart';

class Api_service {
  Future singUp(String phoneNum, String password) async {
    Map data = {
      'phoneNumber': phoneNum,
      'password': password,
    };

    final response = await http.post(Uri.parse(ApiConstants.register),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body);
      String number = dataa['data']['phoneNumber'];

      Prefs.prefs!.setString('user', number);
    }
    return response.statusCode;
  }

  Future Login(String phoneNum, String password) async {
    Map data = {
      'phoneNumber': phoneNum,
      'password': password,
    };

    final response = await http.post(Uri.parse(ApiConstants.login),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // .timeout(const Duration(seconds: 12));

    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body);
      String token = dataa['data']['token'];
      Prefs.prefs!.setString('token', token);
    }

    return response.statusCode;
  }

  Future transfer(String phoneNum, String amount) async {
    Map data = {
      'phoneNumber': phoneNum,
      'amount': amount,
    };

    final response = await http.post(Uri.parse(ApiConstants.transfer),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    return response.statusCode;
  }

  Future withdraw(String phoneNum, String amount) async {
    Map data = {
      'phoneNumber': phoneNum,
      'amount': amount,
    };

    final response = await http.post(Uri.parse(ApiConstants.withdraw),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    return response.statusCode;
  }

  getTransaction() async {
    final response = await http.get(Uri.parse(ApiConstants.getList));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> data = body['data'];
      List<Transaction> transaction =
          data.map((e) => Transaction.fromJson(e)).toList();
      var userNum = Prefs.prefs!.getString('user');
      final filteredNumdata = transaction
          .where((element) => element.phoneNumber == '$userNum')
          .toList();
      debugPrint('this is you list ${filteredNumdata.runtimeType}.');
      // List<Transaction> product =
      //     body.map((dynamic item) => Transaction.fromJson(item)).toList();
      // Transaction transactions = Transaction.fromJson(body);

      return filteredNumdata.reversed.toList();
    } else {
      throw ("Can't get list of transaction");
    }
  }

  getCredit() async {
    final response = await http.get(Uri.parse(ApiConstants.getList));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];
      List<Transaction> creditt =
          data.map((e) => Transaction.fromJson(e)).toList();
      var userNum = Prefs.prefs!.getString('user');
      var filteredNumdata = creditt
          .where((element) => element.phoneNumber == '$userNum')
          .toList();
      debugPrint('this is you list $filteredNumdata');
      // List<Transaction> product =
      //     body.map((dynamic item) => Transaction.fromJson(item)).toList();
      // Transaction transactions = Transaction.fromJson(body);
      var credit =
          filteredNumdata.where((element) => element.type == 'credit').toList();
      return credit.reversed.toList();
    }
  }

  getDebit() async {
    final response = await http.get(Uri.parse(ApiConstants.getList));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];
      List<Transaction> debitt =
          data.map((e) => Transaction.fromJson(e)).toList();
      var userNum = Prefs.prefs!.getString('user');

      var filteredNumdata =
          debitt.where((element) => element.phoneNumber == '$userNum').toList();
      debugPrint('this is you list $filteredNumdata');
      // List<Transaction> product =
      //     body.map((dynamic item) => Transaction.fromJson(item)).toList();
      // Transaction transactions = Transaction.fromJson(body);

      var debit =
          filteredNumdata.where((element) => element.type == 'debit').toList();
      return debit.reversed.toList();
    }
  }

  getBalance() async {
    final response = await http.get(Uri.parse(ApiConstants.users));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['data'];
      List<Users> ussers = data.map((e) => Users.fromJson(e)).toList();

      String? userNum = Prefs.prefs!.getString('user');
      var filteredNumdata =
          ussers.firstWhere((element) => element.phoneNumber == '$userNum');

      return filteredNumdata.balance;
    }
  }
}
