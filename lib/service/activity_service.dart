import 'dart:convert';

import 'package:http/http.dart';

import '../model/activity_model.dart';
import '../model/image_details_model.dart';
import '../model/session_by_id_model.dart';
import '../model/session_model.dart';
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

  Future<List<Session>> getSession() async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/sessiontime.php'),
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
      final sessionTime = sessionTimeFromJson(response.body);
      return sessionTime.records!;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future<List<ListSessionRecord>?> getSessionById(activityId) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/get_session_by_id.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
        "activityId": activityId,
      }),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });

    if (response.statusCode == 200) {
      final listSessionRecords = listSessionRecordsFromJson(response.body);
      return listSessionRecords.listSessionRecords;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future updateActivity(jsons) async {
    print(json.encode(jsons));
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/update_activity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsons),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });
    print(response.body);
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
      body: json.encode(jsons),
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

  Future goToInsertSpecialBooking(jsons) async {
    final response = await post(
      Uri.parse(
          'https://rentasadventures.com/API/insert_image_details_activities.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", ...jsons}),
    ).catchError((onError) {
      print(onError);
      const SnackBars().snackBarFail("Error", "");
    });

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }

  Future<List<ImageDetail>> getImageDetails(id) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/get_image_activity.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'authKey': "key123", 'idActivity': id}),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
      return [];
    });

    if (response.statusCode == 200) {
      final imageDetails = imageDetailsFromJson(response.body);
      return imageDetails.imageDetails!;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return [];
    }
  }

  Future goToInsertDetailsImage(jsons) async {
    final response = await post(
      Uri.parse(
          'https://rentasadventures.com/API/insert_image_details_activities.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsons),
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
