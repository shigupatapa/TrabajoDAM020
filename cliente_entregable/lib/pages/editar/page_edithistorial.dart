import 'dart:ui';

import 'package:cliente_entregable/provider/historial_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageEditHistorial extends StatefulWidget {
  int nHistorial;
  String rut;
  String titulo;
  PageEditHistorial(this.nHistorial, this.rut, this.titulo, {Key? key})
      : super(key: key);

  @override
  State<PageEditHistorial> createState() => _PageEditHistorialState();
}

class _PageEditHistorialState extends State<PageEditHistorial> {
  TextEditingController rutNinoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  DateTime date = DateTime.now();
  String errTitulo = '', errContenido = '';

  @override
  void initState() {
    super.initState();
    HistorialesProvider().getHistorial(widget.nHistorial).then((data) {
      tituloCtrl.text = data['titulo'];
      contenidoCtrl.text = data['contenido'];
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${widget.titulo}"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: tituloCtrl,
                        decoration: InputDecoration(
                          labelText: 'Titulo',
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
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: contenidoCtrl,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Contenido',
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
                    ),
                    if (errContenido != "")
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.red,
                        child: Text(
                          errTitulo,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    Divider(),
                    Container(
                      child: ElevatedButton(
                        child: Text('Editar Historial'),
                        onPressed: () async {
                          var respuesta =
                              await HistorialesProvider().UpdateHistorial(
                            widget.nHistorial,
                            widget.rut,
                            tituloCtrl.text.trim(),
                            contenidoCtrl.text.trim(),
                          );
                          if (respuesta['message'] != null) {
                            if (respuesta['error']['titulo'] != null) {
                              errTitulo = respuesta['error']['titulo'][0];
                            }
                            if (respuesta['error']['contenido'] != null) {
                              errContenido = respuesta['error']['contenido'][0];
                            }
                            setState(() {});
                            return;
                          }
                          print(respuesta);
                          Navigator.pop(context);
                          String titulo = tituloCtrl.text.trim();
                          showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                              message: '$titulo fue editado exitosamente.',
                              backgroundColor: Colors.green,
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.black26,
                                size: 120,
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
