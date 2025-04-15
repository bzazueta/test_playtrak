// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String respuesta;
  List<ApiCrud> apiCrud;

  User({
    required this.respuesta,
    required this.apiCrud,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    respuesta: json["Respuesta"],
    apiCrud: List<ApiCrud>.from(json["api_crud"].map((x) => ApiCrud.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Respuesta": respuesta,
    "api_crud": List<dynamic>.from(apiCrud.map((x) => x.toJson())),
  };
}

class ApiCrud {
  String respuesta;
  int id;
  String name;
  String image;
  String date;
  String phone;

  ApiCrud({
    required this.respuesta,
    required this.id,
    required this.name,
    required this.image,
    required this.date,
    required this.phone
  });

  factory ApiCrud.fromJson(Map<String, dynamic> json) => ApiCrud(
    respuesta: json["Respuesta"],
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    date: json["date"] ?? '',
    phone: json["phone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Respuesta": respuesta,
    "id": id,
    "name": name,
    "image": image,
    "date": date,
    "phone" :phone
  };
}
