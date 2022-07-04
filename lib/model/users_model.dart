import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.statusCode,
    this.data,
  });

  num? statusCode;
  List<Datum>? data;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      statusCode: json["statusCode"],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.role,
    this.email,
    this.phone,
  });

  String? id;
  String? name;
  String? role;
  String? email;
  String? phone;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "email": email,
        "phone": phone,
      };
}
