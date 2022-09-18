import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';

import '../model/transaction_model.dart';
import '../widgets/snackbars.dart';

class TransactionService {
  Future<List<Record>?> getTransactionByDateRange(
      {required String startDate, required String endDate}) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/transaction_date_range.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
        'startDate': startDate,
        'endDate': endDate
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error in transaction", "");
    });

    if (response.statusCode == 200) {
      final listTransaction = listTransactionFromJson(response.body);
      return listTransaction.records;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future<List<Record>?> getTransaction() async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/get_transaction.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error in transaction", "");
    });

    if (response.statusCode == 200) {
      final listTransaction = listTransactionFromJson(response.body);
      return listTransaction.records;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future<List<Record>?> getTransactionToday() async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/today_transaction.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error in transaction", "");
    });

    if (response.statusCode == 200) {
      final listTransaction = listTransactionFromJson(response.body);
      return listTransaction.records;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }
}
