import 'dart:convert';

Plat platFromJson(String str) => Plat.fromJson(json.decode(str));

String platToJson(Plat data) => json.encode(data.toJson());

class Plat {
  int id;
  String nom;
  String duree;
  String level;
  String image;
  int idType;
  String description;

  Plat({
    required this.id,
    required this.nom,
    required this.duree,
    required this.level,
    required this.image,
    required this.idType,
    required this.description,
  });

  factory Plat.fromJson(Map<String, dynamic> json) => Plat(
        id: json["id"],
        nom: json["nom"],
        duree: json["duree"],
        level: json["level"],
        image: json["image"],
        idType: json["id_type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "duree": duree,
        "level": level,
        "image": image,
        "id_type": idType,
        "description": description,
      };
}
