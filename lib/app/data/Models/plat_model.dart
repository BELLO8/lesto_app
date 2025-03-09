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
        nom: json["nom"] ?? "",
        duree: json["duree"] ?? "1 heure",
        level: json["level"] ?? "Moyen",
        image: json["image"] ??
            "https://lesaventuresdekonan.home.blog/wp-content/uploads/2019/05/save_20190512_0740571049105813.jpeg",
        idType: json["id_type"] ?? 0,
        description: json["description"] ?? "",
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
