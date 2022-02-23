import 'package:appo_lab/src/models/cita_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CitaService {
  CitaService();
  final String _rootUrl = 
      "https://appo-backend.herokuapp.com/appointments";

  Future<List<Cita>> getCita() async {
    List<Cita> result = [];

    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if(response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for(var item in listBody){
        final cita = Cita.fromJson(item);
        result.add(cita);
      }
      return result;
    }catch (ex) {
      return result;
    }
  }
  Future<List<Cita>> getCitaUser(String id) async {
    List<Cita> result = [];

    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if(response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for(var item in listBody){
        final cita = Cita.fromJson(item);
        if (cita.user==id) {
          result.add(cita);
        }
        
      }
      return result;
    }catch (ex) {
      return result;
    }
  }
  Future<int> postCita(Cita cita) async {
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      String _citaBody = citaToJson(cita);
      var url = Uri.parse(_rootUrl);
      final response = await http.post(url, headers: _headers, body: _citaBody);
      if (response.body.isEmpty) return 400;
      //Map<String, dynamic> content = json.decode(response.body);
      return response.statusCode;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return 500;
    }
  }
}