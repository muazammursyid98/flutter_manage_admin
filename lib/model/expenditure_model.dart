// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';

Expenditure expenditureFromJson(String str) =>
    Expenditure.fromJson(json.decode(str));

String expenditureToJson(Expenditure data) => json.encode(data.toJson());

class Expenditure {
  num? statusCode;
  // List<Map<String, String>>? data;
  List<Datum>? data;

  Expenditure({
    this.statusCode,
    this.data,
  });

  factory Expenditure.fromJson(Map<String, dynamic> json) {
    return Expenditure(
      statusCode: json["statusCode"],
      // data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x)
      //     .map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        // "data": List<dynamic>.from(data!.map((x) => Map.from(x).map(
        //     (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    this.stage,
    this.amount,
    this.purpose,
    this.requester,
    this.approver,
    this.category,
    this.approved,
    this.payer,
    this.timestampRequest,
    this.timestampApproval,
    this.timestampPayment,
    this.timestampComplete,
  });

  String id;
  String? stage;
  String? amount;
  String? purpose;
  String? requester;
  String? approver;
  String? category;
  String? approved;
  String? payer;
  String? timestampRequest;
  String? timestampApproval;
  String? timestampPayment;
  String? timestampComplete;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stage: json["stage"],
        amount: json["amount"],
        purpose: json["purpose"],
        requester: json["requester"],
        approver: json["approver"],
        category: json["category"],
        approved: json["approved"],
        payer: json["payer"],
        timestampRequest: json["timestamp_request"],
        timestampApproval: json["timestamp_approval"],
        timestampPayment: json["timestamp_payment"],
        timestampComplete: json["timestamp_complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stage": stage,
        "amount": amount,
        "purpose": purpose,
        "requester": requester,
        "approver": approver,
        "category": category,
        "approved": approved,
        "payer": payer,
        "timestamp_request": timestampRequest,
        "timestamp_approval": timestampApproval,
        "timestamp_payment": timestampPayment,
        "timestamp_complete": timestampComplete,
      };
}
