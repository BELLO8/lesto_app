// To parse this JSON data, do
//
//     final dish = dishFromJson(jsonString);

import 'dart:convert';

Dish dishFromJson(String str) => Dish.fromJson(json.decode(str));

String dishToJson(Dish data) => json.encode(data.toJson());

class Dish {
  DateTime date;
  String name;
  List<Plat> plats;

  Dish({
    required this.date,
    required this.name,
    required this.plats,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        date: DateTime.parse(json["date"]),
        name: json["name"],
        plats: List<Plat>.from(json["plats"].map((x) => Plat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
        "plats": List<dynamic>.from(plats.map((x) => x.toJson())),
      };
}

class Plat {
  int id;
  String libelle;
  String duree;
  String image;
  String description;
  String level;

  Plat({
    required this.id,
    required this.libelle,
    required this.duree,
    required this.image,
    required this.description,
    required this.level,
  });

  factory Plat.fromJson(Map<String, dynamic> json) => Plat(
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
