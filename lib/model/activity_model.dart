// To parse this JSON data, do
//
//     final listActivity = listActivityFromJson(jsonString);

import 'dart:convert';

ListActivity listActivityFromJson(String str) =>
    ListActivity.fromJson(json.decode(str));

String listActivityToJson(ListActivity data) => json.encode(data.toJson());

class ListActivity {
  ListActivity({
    this.records,
    this.message,
    this.reason,
  });

  List<Record>? records;
  String? message;
  String? reason;

  factory ListActivity.fromJson(Map<String, dynamic> json) => ListActivity(
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
  Record(
      {this.activityId,
      this.activityName,
      this.activityAvailable,
      this.activityLocation,
      this.activityAsset,
      this.activityPrice});

  String? activityId;
  String? activityName;
  String? activityAvailable;
  String? activityLocation;
  String? activityAsset;
  String? activityPrice;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        activityId: json["activityId"],
        activityName: json["activityName"],
        activityAvailable: json["activityAvailable"] == null
            ? null
            : json["activityAvailable"],
        activityLocation: json["activityLocation"],
        activityAsset: json["activityAsset"],
        activityPrice: json["activityPrice"],
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "activityName": activityName,
        "activityAvailable":
            activityAvailable == null ? null : activityAvailable,
        "activityLocation": activityLocation,
        "activityAsset": activityAsset,
      };
}
