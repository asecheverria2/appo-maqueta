// To parse this JSON data, do
//
//     final laboratorio = laboratorioFromJson(jsonString);

import 'dart:convert';

Laboratorio laboratorioFromJson(String str) => Laboratorio.fromJson(json.decode(str));

String laboratorioToJson(Laboratorio data) => json.encode(data.toJson());

class Laboratorio {
    Laboratorio({
        this.id,
        this.name,
        this.latitude,
        this.longitude,
    });

    String? id;
    String? name;
    double? latitude;
    double? longitude;

    factory Laboratorio.fromJson(Map<String, dynamic> json) => Laboratorio(
      id: json["id"],
      name: json["name"],
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
    };
}
