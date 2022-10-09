import 'dart:convert';

import '../model/calendar_model.dart';
import '../widgets/snackbars.dart';
import 'package:http/http.dart';

class OverviewService {
  Future<List<Record>?> calendarOverview(jsons) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/month_transaction.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", ...jsons}),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });
    if (response.statusCode == 200) {
      final calendarModel = calendarModelFromJson(response.body);
      return calendarModel.records;
    } else {
      return [];
    }
  }
}
