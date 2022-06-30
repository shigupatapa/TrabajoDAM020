import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfesoresProvider {
  //final String apiURL = 'http://192.168.138.130:8000/api';
  //final String apiURL = 'http://10.0.2.2:8000/api'; // EMULADOR
  final String apiURL = 'http://192.168.1.160:8000/api'; // ENZO

  // LISTAR PROFES
  Future<List<dynamic>> getAllProfes() async {
    var uri = Uri.parse('$apiURL/profesores');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // INFO DE UN PROFE
  Future<LinkedHashMap<String, dynamic>> getProfe(String rutProfesor) async {
    var uri = Uri.parse('$apiURL/profesores/$rutProfesor');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  // AGREGAR PROFE
  Future<LinkedHashMap<String, dynamic>> AddProfe(
    String rutProfesor,
    String nombreCompleto,
    String sexo,
    DateTime fechaNacimiento,
    int nivel,
  ) async {
    var uri = Uri.parse('$apiURL/profesores');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'rutProfesor': rutProfesor,
          'nombreCompleto': nombreCompleto,
          'sexo': sexo,
          'fechaNacimiento': fechaNacimiento.toString(),
          'nivel_id': nivel,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // EDITAR PROFE
  Future<LinkedHashMap<String, dynamic>> UpdateProfe(
      bool editar,
      String rut,
      String rutProfesor,
      String nombreCompleto,
      String sexo,
      String fechaNacimiento,
      int nivel) async {
    if (editar) {
      var uri = Uri.parse('$apiURL/profesores/rut/$rut');
      var respuesta = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            'rutProfesor': rutProfesor,
            'nombreCompleto': nombreCompleto,
            'fechaNacimiento': fechaNacimiento,
            'sexo': sexo,
            'nivel_id': nivel,
          },
        ),
      );
      return json.decode(respuesta.body);
    } else {
      var uri = Uri.parse('$apiURL/profesores/$rut');
      var respuesta = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            'rutProfesor': rutProfesor,
            'nombreCompleto': nombreCompleto,
            'fechaNacimiento': fechaNacimiento,
            'sexo': sexo,
            'nivel_id': nivel,
          },
        ),
      );
      return json.decode(respuesta.body);
    }
  }

  // ELIMINAR PROFE
  Future<bool> DeleteProfe(String rutProfesor) async {
    var uri = Uri.parse('$apiURL/profesores/$rutProfesor');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
