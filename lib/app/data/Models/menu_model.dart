// To parse this JSON data, do
//
//     final dish = dishFromJson(jsonString);

import 'dart:convert';

Dish dishFromJson(String str) => Dish.fromJson(json.decode(str));

String dishToJson(Dish data) => json.encode(data.toJson());

class Dish {
  DateTime date;
  String name;
  List<PlatMenu> plats;

  Dish({
    required this.date,
    required this.name,
    required this.plats,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        date: DateTime.parse(json["date"]),
        name: json["name"],
        plats:
            List<PlatMenu>.from(json["plats"].map((x) => PlatMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
        "plats": List<dynamic>.from(plats.map((x) => x.toJson())),
      };
}

class PlatMenu {
  int id;
  String libelle;
  String duree;
  String image;
  String description;
  String level;

  PlatMenu({
    required this.id,
    required this.libelle,
    required this.duree,
    required this.image,
    required this.description,
    required this.level,
  });

  factory PlatMenu.fromJson(Map<String, dynamic> json) => PlatMenu(
        id: json["id"] ?? "",
        libelle: json["libelle"] ?? "",
        duree: json["duree"] ?? "",
        image: json["image"] ??
            "https://lesaventuresdekonan.home.blog/wp-content/uploads/2019/05/save_20190512_0740571049105813.jpeg",
        description: json["description"] ?? "",
        level: json["level"] ?? "",
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
