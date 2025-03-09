import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Flags flags;
  Name name;

  Country({
    required this.flags,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        flags: Flags.fromJson(json["flags"]),
        name: Name.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "flags": flags.toJson(),
        "name": name.toJson(),
      };
}

class Flags {
  String png;
  String svg;
  String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Name {
  String common;

  Name({
    required this.common,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
      );

  Map<String, dynamic> toJson() => {
        "common": common,
      };
}
