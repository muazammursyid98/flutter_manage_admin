// To parse this JSON data, do
//
//     final salesSummary = salesSummaryFromJson(jsonString);

import 'dart:convert';

SalesSummary salesSummaryFromJson(String str) =>
    SalesSummary.fromJson(json.decode(str));

String salesSummaryToJson(SalesSummary data) => json.encode(data.toJson());

class SalesSummary {
  SalesSummary({
    this.salesToday,
    this.salesWeekly,
    this.salesMonthly,
    this.salesYearly,
    this.message,
    this.reason,
  });

  String? salesToday;
  String? salesWeekly;
  String? salesMonthly;
  String? salesYearly;
  String? message;
  String? reason;

  factory SalesSummary.fromJson(Map<String, dynamic> json) => SalesSummary(
        salesToday: json["salesToday"] ?? "0",
        salesWeekly: json["salesWeekly"] ?? "0",
        salesMonthly: json["salesMonthly"] ?? "0",
        salesYearly: json["salesYearly"] ?? "0",
        message: json["message"] ?? "0",
        reason: json["reason"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "salesToday": salesToday,
        "salesWeekly": salesWeekly,
        "salesMonthly": salesMonthly,
        "salesYearly": salesYearly,
        "message": message,
        "reason": reason,
      };
}
