import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appo_lab/src/models/usuario_data_model.dart';

class UsuarioService {
  UsuarioService();
  final String _rootUrl = "https://appo-backend.herokuapp.com/datos-personales";

  Future<int> postUsuario(UsuarioDatos usuario) async {
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      String _usuarioBody = usuarioToJson(usuario);
      var url = Uri.parse(_rootUrl);
      final response = await http.post(url, headers: _headers, body: _usuarioBody);
      if (response.body.isEmpty) return 400;
      //Map<String, dynamic> content = json.decode(response.body);
      return json.decode(response.body);
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return 500;
    }
  }

  Future<String> uploadImage(File image) async {
    final cloudinary = CloudinaryPublic('dnvtt9usn', 'ml_default', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      // ignore: avoid_print
      print(e.message);
      // ignore: avoid_print
      print(e.request);
      return "";
    }
  }
}
