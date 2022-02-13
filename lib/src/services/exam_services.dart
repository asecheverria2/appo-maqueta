import 'package:appo_lab/src/models/exam_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamenesService {
  ExamenesService();
  final String _rootUrl = 
      "https://appo-backend.herokuapp.com/exams";

  Future<List<Examenes>> getExamen() async {
    List<Examenes> result = [];

    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if(response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for(var item in listBody){
        final examenes = Examenes.fromJson(item);
        result.add(examenes);
      }
      return result;
    }catch (ex) {
      return result;
    }
  }
}