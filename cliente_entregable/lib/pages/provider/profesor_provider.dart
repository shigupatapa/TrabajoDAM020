import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductosProvider {
  final String apiURL = 'http://localhost:8000/api';

  //Lista Todos
  Future<List<dynamic>> getAllProfes() async {
    var uri = Uri.parse('$apiURL/profesores');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //1 Historial
  Future<LinkedHashMap<String, dynamic>> getProfe(String rutProfesor) async {
    var uri = Uri.parse('$apiURL/profesores/$rutProfesor');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //ADD Hist
  Future<LinkedHashMap<String, dynamic>> AddProfe(
    String rutProfesor,
    String nombreCompleto,
    DateTime fechaNacimiento,
    int nivel,
  ) async {
    var uri = Uri.parse('$apiURL/profesores');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutProfesor': rutProfesor,
          'nombreCompleto': nombreCompleto,
          'fechaNacimiento': fechaNacimiento,
          'nivel': nivel
        }));
    return json.decode(respuesta.body);
  }

  //Edicion Hist
  Future<LinkedHashMap<String, dynamic>> UpdateProfe(String rutProfesor,
      String nombreCompleto, DateTime fechaNacimiento, int nivel) async {
    var uri = Uri.parse('$apiURL/profesores/$rutProfesor');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutProfesor': rutProfesor,
          'nombreCompleto': nombreCompleto,
          'fechaNacimiento': fechaNacimiento,
          'nivel': nivel
        }));
    return json.decode(respuesta.body);
  }

  //Delete
  Future<bool> DeleteProfe(String rutProfesor) async {
    var uri = Uri.parse('$apiURL/profesores/$rutProfesor');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
