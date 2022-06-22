import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NivelesProvider {
  final String apiURL = 'http://localhost:8000/api';
  // final String apiURL = 'http://192.168.100.72:8000/api';

  //Lista Todos
  Future<List<dynamic>> getAllNiveles() async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //1 nivel
  Future<LinkedHashMap<String, dynamic>> getNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //ADD nivel
  Future<LinkedHashMap<String, dynamic>> AddNivel(
    String nombreNivel,
    int nivel,
  ) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
            <String, dynamic>{'nombreNivel': nombreNivel, 'nivel': nivel}));
    return json.decode(respuesta.body);
  }

  //Edicion nivel
  Future<LinkedHashMap<String, dynamic>> UpdateNivel(
      String nombreNivel, int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{'nombreNivel': nombreNivel}));
    return json.decode(respuesta.body);
  }

  //Delete nivel
  Future<bool> DeleteNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
