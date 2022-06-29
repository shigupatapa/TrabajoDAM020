import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NinosProvider {
  final String apiURL = 'http://192.168.138.130:8000/api';
  //final String apiURL = 'http://10.0.2.2:8000/api'; // EMULADOR
  //final String apiURL = 'http://192.168.1.160:8000/api'; // ENZO

  // LISTAR TODOS LOS NIÑOS
  Future<List<dynamic>> getAllNinos() async {
    var uri = Uri.parse('$apiURL/niños');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  // INFO DE UN NIÑO
  Future<LinkedHashMap<String, dynamic>> getNino(String rutNino) async {
    var uri = Uri.parse('$apiURL/niños/$rutNino');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  // HISTORIAL DE UN NIÑO
  Future<List<dynamic>> getHistorial(String rutNino) async {
    var uri = Uri.parse('$apiURL/niños/$rutNino/historial');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
  
  // AGREGAR NIÑO
  Future<LinkedHashMap<String, dynamic>> AddNino(
    String rutNino,
    String nombreCompleto,
    String sexo,
    DateTime fechaNacimiento,
    String nombreApoderado,
    int nivel,
    String telefono1,
    String telefono2,
    String alergias,
  ) async {
    var uri = Uri.parse('$apiURL/niños');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'rutNino': rutNino,
          'sexo': sexo,
          'nombreCompleto': nombreCompleto,
          'nombreApoderado': nombreApoderado,
          'fechaNacimiento': fechaNacimiento.toString(),
          'nivel_id': nivel,
          'telefono1': telefono1,
          'telefono2': telefono2,
          'alergias': alergias,
        },
      ),
    );
    return json.decode(respuesta.body);
  }

  // EDITAR NIÑO
  Future<LinkedHashMap<String, dynamic>> UpdateNino(
    bool editar,
    String rut,
    String rutNino,
    String nombreCompleto,
    String sexo,
    String fechaNacimiento,
    String nombreApoderado,
    int nivel,
    String telefono1,
    String telefono2,
    String alergias,
  ) async {
    if (editar) {
      var uri = Uri.parse('$apiURL/niños/rut/$rut');
      var respuesta = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            'rutNino': rutNino,
            'sexo': sexo,
            'nombreCompleto': nombreCompleto,
            'nombreApoderado': nombreApoderado,
            'fechaNacimiento': fechaNacimiento,
            'nivel_id': nivel,
            'telefono1': telefono1,
            'telefono2': telefono2,
            'alergias': alergias,
          },
        ),
      );
      return json.decode(respuesta.body);
    } else {
      var uri = Uri.parse('$apiURL/niños/$rut');
      var respuesta = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            'rutNino': rutNino,
            'sexo': sexo,
            'nombreCompleto': nombreCompleto,
            'nombreApoderado': nombreApoderado,
            'fechaNacimiento': fechaNacimiento,
            'nivel_id': nivel,
            'telefono1': telefono1,
            'telefono2': telefono2,
            'alergias': alergias,
          },
        ),
      );
      return json.decode(respuesta.body);
    }
  }

  // BORRAR NIÑO
  Future<bool> DeleteNino(String rutNino) async {
    var uri = Uri.parse('$apiURL/niños/$rutNino');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
