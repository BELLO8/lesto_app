// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String nom;
  String prenom;
  String password;
  String number;
  String email;

  RegisterModel({
    required this.nom,
    required this.prenom,
    required this.password,
    required this.number,
    required this.email,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        nom: json["nom"],
        prenom: json["prenom"],
        password: json["password"],
        number: json["number"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenom": prenom,
        "password": password,
        "number": number,
        "email": email,
      };
}
