// To parse this JSON data, do
//
//     final cita = citaFromJson(jsonString);

import 'dart:convert';

Cita citaFromJson(String str) => Cita.fromJson(json.decode(str));

String citaToJson(Cita data) => json.encode(data.toJson());

class Cita {
    Cita({
        this.exams,
        this.exams2,
        this.id,
        this.date,
        this.quotation,
        this.lab,
        this.lab2,
        this.user
    });

    List<String>? exams;
    List<Exam>? exams2;
    String? id;
    DateTime? date;
    double? quotation;
    String? lab;
    Lab? lab2;
    String? user;
    factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        exams2: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
        id: json["id"],
        date: DateTime.parse(json["date"]),
        quotation: json["quotation"],
        lab2: Lab.fromJson(json["lab"]),
        user: json["users_permissions_user"],
    );

    Map<String, dynamic> toJson() => {
        "exams": exams,
        //"id": id,
        "date": date.toString(),
        "quotation": quotation,
        "lab": lab,
        "users_permissions_user": user
    };
}

class Exam {
    Exam({
        required this.id,
        required this.name,
        required this.description,
        required this.img,
        required this.price,
    });

    String id;
    String name;
    String description;
    String img;
    double price;

    factory Exam.fromJson(Map<String, dynamic> json) => Exam(
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

class Lab {
    Lab({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
    });

    String id;
    String name;
    double latitude;
    double longitude;

    factory Lab.fromJson(Map<String, dynamic> json) => Lab(
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
