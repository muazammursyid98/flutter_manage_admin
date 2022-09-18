import 'dart:convert';

import 'package:http/http.dart';

import '../model/activity_model.dart';
import '../widgets/snackbars.dart';

class ActivityService {
  Future<List<Record>?> getActivity() async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/getlistactivity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });

    if (response.statusCode == 200) {
      final listActivity = listActivityFromJson(response.body);
      return listActivity.records;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future updateActivity(jsons) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/update_activity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", ...jsons}),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });
    print(jsons);
    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }

  Future insertActivity(jsons) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/insert_activity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", ...jsons}),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }

  Future deleteActivity(jsons) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/delete_activity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", ...jsons}),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }
}
