// To parse this JSON data, do
//
//     final listUsers = listUsersFromJson(jsonString);

import 'dart:convert';

ListUsers listUsersFromJson(String str) => ListUsers.fromJson(json.decode(str));

String listUsersToJson(ListUsers data) => json.encode(data.toJson());

class ListUsers {
  ListUsers({
    this.records,
    this.message,
    this.reason,
  });

  List<Record>? records;
  String? message;
  String? reason;

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        message: json["message"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "records": List<dynamic>.from(records!.map((x) => x.toJson())),
        "message": message,
        "reason": reason,
      };
}

class Record {
  Record({
    this.registrantOrderId,
    this.name,
    this.phoneNumber,
    this.email,
    this.count,
  });

  String? registrantOrderId;
  String? name;
  String? phoneNumber;
  String? email;
  String? count;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        registrantOrderId: json["registrantOrderId"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "registrantOrderId": registrantOrderId,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "count": count,
      };
}
