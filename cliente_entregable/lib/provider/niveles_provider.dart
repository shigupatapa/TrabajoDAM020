import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NivelesProvider {
  final String apiURL = 'http://192.168.138.130:8000/api';
  //final String apiURL = 'http://10.0.2.2:8000/api'; //emulador
  //final String apiURL = 'http://192.168.100.72:8000/api';

  // LISTAR TODOS LOS NIVELES
  Future<List<dynamic>> getAllNiveles() async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // INFO DE UN NIVEL
  Future<LinkedHashMap<String, dynamic>> getNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  // NIÑOS POR NIVEL
  Future<List<dynamic>> getNinosbyNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel/niños');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // PROFES POR NIVEL
  Future<List<dynamic>> getProfesbyNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel/profes');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // AGREGAR NIVEL
  Future<LinkedHashMap<String, dynamic>> AddNivel(
    String nombreNivel,
    String detalles,
  ) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'nombreNivel': nombreNivel,
          'detalles': detalles,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // EDITAR NIVEL
  Future<LinkedHashMap<String, dynamic>> UpdateNivel(
    int nivel,
    String nombreNivel,
    String detalles,
  ) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'nombreNivel': nombreNivel,
          'detalles': detalles,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // ELIMINAR NIVEL
  Future<bool> DeleteNivel(int nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$nivel');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
