import 'package:appo_lab/src/models/lab_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LaboratorioService {
  LaboratorioService();
  final String _rootUrl = "https://appo-backend.herokuapp.com/labs";

  Future<List<Laboratorio>> getLaboratorio() async {
    List<Laboratorio> result = [];

    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if(response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for(var item in listBody){
        final laboratorio = Laboratorio.fromJson(item);
        result.add(laboratorio);
      }
      return result;
    }catch (ex) {
      return result;
    }
  }
}