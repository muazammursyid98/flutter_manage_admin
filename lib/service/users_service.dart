//import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:http/http.dart';

class UsersService {
  //Get all users

  Future<Response> getUsers() async {
    String url = "https://expenditure-tracker-backend.thescienceset.com/users";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);

    return result;
  }

  //Get user buy ID

  Future<Response> getUsersById(int id) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/users/$id";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);

    return result;
  }

// create new user

  Future<Response> createUser({
    String? name,
    String? email,
    String? phone,
    String? role,
  }) {
    return post(
      Uri.parse("https://expenditure-tracker-backend.thescienceset.com/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String?>{
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
      }),
    );
  }

  //delete a user

  Future<Response> deleteUserRequest(String id) async {
    return await delete(Uri.parse(
        "https://expenditure-tracker-backend.thescienceset.com/users/$id"));
  }
}

class ExpService {}

//delete a User


