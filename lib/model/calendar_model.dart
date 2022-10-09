// To parse this JSON data, do
//
//     final calendarModel = calendarModelFromJson(jsonString);

import 'dart:convert';

CalendarModel calendarModelFromJson(String str) =>
    CalendarModel.fromJson(json.decode(str));

String calendarModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
  CalendarModel({
    this.records,
    this.message,
    this.reason,
  });

  List<Record>? records;
  String? message;
  String? reason;

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
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
    this.createdDate,
  });

  DateTime? createdDate;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
      };
}
