// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  int id;
  String libelle;
  String duree;
  String image;
  String description;
  String level;

  Menu({
    required this.id,
    required this.libelle,
    required this.duree,
    required this.image,
    required this.description,
    required this.level,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        libelle: json["libelle"],
        duree: json["duree"],
        image: json["image"],
        description: json["description"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "duree": duree,
        "image": image,
        "description": description,
        "level": level,
      };
}
