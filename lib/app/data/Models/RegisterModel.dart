// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String nom;
  String prenoms;
  String password;
  String telephone;
  String email;

  RegisterModel({
    required this.nom,
    required this.prenoms,
    required this.password,
    required this.telephone,
    required this.email,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        nom: json["nom"],
        prenoms: json["prenoms"],
        password: json["password"],
        telephone: json["telephone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenoms": prenoms,
        "password": password,
        "telephone": telephone,
        "email": email,
      };
}
