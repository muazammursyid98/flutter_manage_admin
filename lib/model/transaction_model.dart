// To parse this JSON data, do
//
//     final listTransaction = listTransactionFromJson(jsonString);

import 'dart:convert';

ListTransaction listTransactionFromJson(String str) =>
    ListTransaction.fromJson(json.decode(str));

String listTransactionToJson(ListTransaction data) =>
    json.encode(data.toJson());

class ListTransaction {
  ListTransaction({
    this.records,
    this.message,
    this.reason,
  });

  List<Record>? records;
  String? message;
  String? reason;

  factory ListTransaction.fromJson(Map<String, dynamic> json) =>
      ListTransaction(
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
    this.orderId,
    this.activityId,
    this.name,
    this.phoneNumber,
    this.email,
    this.activityName,
    this.totalBookedSlot,
    this.totalPrice,
    this.shiftName,
    this.statusId,
    this.createdDate,
  });

  String? registrantOrderId;
  String? orderId;
  String? activityId;
  String? name;
  String? phoneNumber;
  String? email;
  String? activityName;
  String? totalBookedSlot;
  String? totalPrice;
  String? shiftName;
  String? statusId;
  DateTime? createdDate;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        registrantOrderId: json["registrantOrderId"],
        orderId: json["orderId"],
        activityId: json["activityId"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        activityName: json["activityName"],
        totalBookedSlot: json["totalBookedSlot"],
        totalPrice: json["totalPrice"],
        shiftName: json["shiftName"],
        statusId: json["statusId"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "registrantOrderId": registrantOrderId,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "totalBookedSlot": totalBookedSlot,
        "totalPrice": totalPrice,
        "shiftName": shiftName,
        "statusId": statusId,
        "createdDate": createdDate!.toIso8601String(),
      };
}
