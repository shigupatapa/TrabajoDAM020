import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductosProvider {
  final String apiURL = 'http://localhost:8000/api';

  //Lista Todos
  Future<List<dynamic>> getAllNinos() async {
    var uri = Uri.parse('$apiURL/ninos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //1 Historial
  Future<LinkedHashMap<String, dynamic>> getNino(String rutNino) async {
    var uri = Uri.parse('$apiURL/ninos/$rutNino');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //ADD Hist
  Future<LinkedHashMap<String, dynamic>> AddNino(
    String rutNino,
    String nombreCompleto,
    DateTime fechaNacimiento,
    String nombreApoderado,
    int nivel,
    String telefono1,
    String telefono2,
    String alergias,
  ) async {
    var uri = Uri.parse('$apiURL/ninos');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutNino': rutNino,
          'nombreCompleto': nombreCompleto,
          'nombreApoderado': nombreApoderado,
          'fechaNacimiento': fechaNacimiento,
          'nivel': nivel,
          'telefono1': telefono1,
          'telefono2': telefono2,
          'alergias': alergias,
        }));
    return json.decode(respuesta.body);
  }

  //Edicion Hist
  Future<LinkedHashMap<String, dynamic>> UpdateNino(
    String rutNino,
    String nombreCompleto,
    DateTime fechaNacimiento,
    String nombreApoderado,
    int nivel,
    String telefono1,
    String telefono2,
    String alergias,
  ) async {
    var uri = Uri.parse('$apiURL/ninos/$rutNino');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutNino': rutNino,
          'nombreCompleto': nombreCompleto,
          'nombreApoderado': nombreApoderado,
          'fechaNacimiento': fechaNacimiento,
          'nivel': nivel,
          'telefono1': telefono1,
          'telefono2': telefono2,
          'alergias': alergias,
        }));
    return json.decode(respuesta.body);
  }

  //Delete
  Future<bool> DeleteNino(String rutNino) async {
    var uri = Uri.parse('$apiURL/ninos/$rutNino');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
