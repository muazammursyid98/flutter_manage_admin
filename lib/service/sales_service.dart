import 'dart:convert';

import 'package:http/http.dart';

import '../model/sales_model.dart';
import '../widgets/snackbars.dart';

class SalesService {
  Future<SalesSummary?> getSales() async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/get_sales.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });
    print(response.body);
    if (response.statusCode == 200) {
      final salesSummary = salesSummaryFromJson(response.body);
      return salesSummary;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return null;
    }
  }
}
