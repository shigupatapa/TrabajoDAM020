import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HistorialesProvider {
  final String apiURL = 'http://192.168.87.130:8000/api';
  //final String apiURL = 'http://10.0.2.2:8000/api'; // EMULADOR
  //final String apiURL = 'http://192.168.1.160:8000/api'; // ENZO

  // LISTAR HISTORIALES
  Future<List<dynamic>> getAllHistoriales() async {
    var uri = Uri.parse('$apiURL/historiales');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // INFO DE UN HISTORIAL
  Future<LinkedHashMap<String, dynamic>> getHistorial(int nHistorial) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  // AGREGAR HISTORIAL
  Future<LinkedHashMap<String, dynamic>> AddHistorial(
    String rutNino,
    String titulo,
    String contenido,
  ) async {
    var uri = Uri.parse('$apiURL/historiales');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'rutNino': rutNino,
          'titulo': titulo,
          //'fecha': fecha,
          'contenido': contenido
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // EDITAR HISTORIAL
  Future<LinkedHashMap<String, dynamic>> UpdateHistorial(
    int nHistorial,
    String rutNino,
    String titulo,
    //DateTime fecha,
    String contenido,
  ) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'rutNino': rutNino,
          'titulo': titulo,
          //'fecha': fecha,
          'contenido': contenido
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // BORRAR HISTORIAL
  Future<bool> DeleteHistorial(int nHistorial) async {
    var uri = Uri.parse('$apiURL/historiales/$nHistorial');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
