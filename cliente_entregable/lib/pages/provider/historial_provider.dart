import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductosProvider {
  final String apiURL = 'http://localhost:8000/api';

  //Lista Todos
  Future<List<dynamic>> getAllHistotiales() async {
    var uri = Uri.parse('$apiURL/historiales');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //1 Historial
  Future<LinkedHashMap<String, dynamic>> getHistorial(String nHistorial) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //ADD Hist
  Future<LinkedHashMap<String, dynamic>> AddHistorial(
      String rutNino, String titulo, DateTime fecha, String contenido) async {
    var uri = Uri.parse('$apiURL/historiales');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutNino': rutNino,
          'titulo': titulo,
          'fecha': fecha,
          'contenido': contenido
        }));
    return json.decode(respuesta.body);
  }

  //Edicion Hist
  Future<LinkedHashMap<String, dynamic>> UpdateHistorial(int nHistorial,
      String rutNino, String titulo, DateTime fecha, String contenido) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rutNino': rutNino,
          'titulo': titulo,
          'fecha': fecha,
          'contenido': contenido
        }));
    return json.decode(respuesta.body);
  }

  //Delete
  Future<bool> DeleteHistorial(int nHistorial) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
