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
}