import 'dart:ui';

import 'package:cliente_entregable/provider/historial_provider.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';

class PageEditHistorial extends StatefulWidget {
  int nivel;
  String rut;
  PageEditHistorial(this.nivel, this.rut, {Key? key}) : super(key: key);

  @override
  State<PageEditHistorial> createState() => _PageEditHistorialState();
}

class _PageEditHistorialState extends State<PageEditHistorial> {
  DateTime date = DateTime.now();
  TextEditingController rutNinoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  String errRut = '', errTitulo = '', errContenido = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NivelesProvider().getNivel(widget.nivel).then((data) {
      rutNinoCtrl.text = data['rutNino'];
      tituloCtrl.text = data['titulo'];
      contenidoCtrl.text = data['contenido'];
      setState(() {});
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text("Editar Perfil de ${widget.nombre}"),
        title: Text("Editar Perfil"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: Colors.black87),
              ),
              child: ListView(children: [
                TextFormField(
                  controller: tituloCtrl,
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    // do something
                  },
                ),
                if (errTitulo != "")
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.red,
                    child: Text(
                      errTitulo,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                Divider(),
                TextFormField(
                  controller: tituloCtrl,
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    // do something
                  },
                ),
                if (errTitulo != "")
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.red,
                    child: Text(
                      errTitulo,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                Divider(),
                TextFormField(
                  maxLines: 5,
                  controller: contenidoCtrl,
                  decoration: InputDecoration(
                    hintText: 'Descripción',
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    // do something
                  },
                ),
                if (errContenido != "")
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.red,
                    child: Text(
                      errContenido,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                Divider(),
                Container(
                  child: ElevatedButton(
                    child: Text('Editar Profesor'),
                    onPressed: () async {
                      var respuesta = await HistorialesProvider()
                          .UpdateHistorial(
                              widget.nivel,
                              rutNinoCtrl.text.trim(),
                              tituloCtrl.text.trim(),
                              contenidoCtrl.text.trim());
                      if (respuesta['message'] != null) {
                        if (respuesta['error']['rutNino'] != null) {
                          errRut = respuesta['error']['rutNino'][0];
                        }
                        if (respuesta['error']['titulo'] != null) {
                          errTitulo = respuesta['error']['titulo'][0];
                        }
                        if (respuesta['error']['contenido'] != null) {
                          errContenido = respuesta['error']['contenido'][0];
                        }
                        setState(() {});
                      }

                      print(respuesta);
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

//
}
