import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String telephone;
  String password;

  LoginModel({
    required this.telephone,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        telephone: json["telephone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "telephone": telephone,
        "password": password,
      };
}
