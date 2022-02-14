import 'dart:convert';
import 'package:appo_lab/src/models/user_model.dart';
//import 'package:appo_lab/src/models/usuario_data_model.dart';
import 'package:http/http.dart' as http;

class UserService {
 UserService();
  //send users
  Future<dynamic> sendUser(Usuario user) async {
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      var uri = Uri.https("appo-backend.herokuapp.com", "/auth/local/register");
      final resp =
          await http.post(uri, headers: _headers, body: userToJson(user));
      if (resp.body.isEmpty) return null;
      return json.decode(resp.body);
    } on Exception catch (e) {
      print("Exception $e");
      return null;
    }
  }
  //login 
  Future<dynamic> loginUser(String email, String password) async {
    final authData = {
      'identifier': email,
      'password': password,
    };
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      var uri = Uri.https("appo-backend.herokuapp.com", "/auth/local");
      final resp =
          await http.post(uri, headers: _headers, body: json.encode(authData));
      if (resp.body.isEmpty) return null;
      if(resp.statusCode == 200) {
        print(resp.body);
      }else{
        print(resp.body);
        
      }
      return json.decode(resp.body);
    } on Exception catch (e) {
      print("Exception $e");
      return null;
    }
  }
}
