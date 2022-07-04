import 'dart:convert';
import 'package:http/http.dart';

import '../model/users_model.dart';
import '../service/users_service.dart';

class UsersController {
  final UsersService _userService = UsersService();

  //get all users

  Future<Users?> getUsers() async {
    Users? _users;

    Response _response = await _userService.getUsers();

    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _users = Users.fromJson(decoded);
    } else {
      //failure
      print('failed');
      _users = null;
    }
    //print('returning users');
    return _users;
  }

  //get all users

  Future<Users?> getUsersById(int id) async {
    Users? _users;

    Response _response = await _userService.getUsersById(id);

    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _users = Users.fromJson(decoded);
    } else {
      //failure
      print('failed');
      _users = null;
    }
    //print('returning users');
    return _users;
  }

  // create a new user

  Future<bool> createUser({
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    bool success = false;
    var _response = await _userService.createUser(
        name: name, email: email, phone: phone, role: role);

    int statusCode = _response.statusCode;
    print(_response);

    if (statusCode == 201) {
      success = true;
    } else {
      print(statusCode);
    }
    return success;
  }

  /* Future<Users> createUser({
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    final response = await post(
      Uri.parse('https://expenditure-tracker-backend.thescienceset.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Users.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create User.');
    }
  } */

  //delete a user

  Future<bool> deleteUser(String id) async {
    bool isDeleted = false;
    var _response = await _userService.deleteUserRequest(id);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //delete success
      isDeleted = true;
      print(' deleted');
    } else {
      // delete error
      isDeleted = false;
      print('failed to delete');
    }

    return isDeleted;
  }
}
