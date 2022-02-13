import 'dart:convert';

Usuario userFromJson(String str) => Usuario.fromJson(json.decode(str));

String userToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.username,
        this.email,
        this.password,
    });
    Usuario.create(this.username, this.email, this.password);

    String? username;
    String? email;
    String? password;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        username: json["username"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
    };
}
