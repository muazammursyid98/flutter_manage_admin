import 'package:http/http.dart';
import 'dart:convert';

import '../model/users_model.dart';

class AuthenticationService {
  //Get all authentication
  Future<int> authenticationLogin({
    required String username,
    required String password,
  }) async {
    final response = await post(
      Uri.parse('https://rentasadventures.com/API/login_admin.php'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'authKey': "key123",
        'username': username,
        'password': password,
      }),
    ).catchError((onError) {
      throw Exception('Failed to create User.');
    });

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return 200;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create User.');
    }
  }
}
