import 'dart:convert';

UsuarioDatos usuarioFromJson(String str) => UsuarioDatos.fromJson(json.decode(str));

String usuarioToJson(UsuarioDatos data) => json.encode(data.toJson());

class UsuarioDatos {
    UsuarioDatos({
        this.id,
        this.img,
        this.nombre,
        this.numero,
        this.direccion,
    });

    String? id;
    String? img;
    String? nombre;
    String? numero;
    String? direccion;

    factory UsuarioDatos.fromJson(Map<String, dynamic> json) => UsuarioDatos(
        id: json["id"],
        img: json["img"],
        numero: json["numero"],
        direccion: json["direccion"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "img": img,
        "numero": numero,
        "direccion": direccion,
    };
}
