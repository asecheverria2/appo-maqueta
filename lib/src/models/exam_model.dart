// To parse this JSON data, do
//
//     final examenes = examenesFromJson(jsonString);

import 'dart:convert';

Examenes examenesFromJson(String str) => Examenes.fromJson(json.decode(str));

String examenesToJson(Examenes data) => json.encode(data.toJson());

class Examenes {
    Examenes({
        this.id,
        this.name,
        this.description,
        this.img,
        this.price,
    });

    String? id;
    String? name;
    String? description;
    String? img;
    double? price;

    factory Examenes.fromJson(Map<String, dynamic> json) => Examenes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        img: json["img"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "img": img,
        "price": price,
    };
}
