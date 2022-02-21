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
        this.users_permissions_user
    });

    String? id;
    String? img;
    String? nombre;
    String? numero;
    String? direccion;
    String? users_permissions_user;

    factory UsuarioDatos.fromJson(Map<String, dynamic> json) => UsuarioDatos(
        id: json["id"],
        img: json["img"],
        numero: json["numero"],
        direccion: json["direccion"],
        users_permissions_user: json["users_permissions_user"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "img": img,
        "numero": numero,
        "direccion": direccion,
        "users_permissions_user": users_permissions_user
    };
}
