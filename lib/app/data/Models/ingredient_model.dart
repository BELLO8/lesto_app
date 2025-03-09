// To parse this JSON data, do
//
//     final ingredient = ingredientFromJson(jsonString);

import 'dart:convert';

List<Ingredient> ingredientFromJson(String str) =>
    List<Ingredient>.from(json.decode(str).map((x) => Ingredient.fromJson(x)));

String ingredientToJson(List<Ingredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ingredient {
  String nom;
  int quantite;
  String unite;
  String commentaire;

  Ingredient({
    required this.nom,
    required this.quantite,
    required this.unite,
    required this.commentaire,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        nom: json["nom"] ?? "",
        quantite: json["quantite"] ?? 0,
        unite: json["unite"] ?? "",
        commentaire: json["commentaire"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "quantite": quantite,
        "unite": unite,
        "commentaire": commentaire,
      };
}
