import 'dart:ui';

import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class PageNivelEdit extends StatefulWidget {
  int nivel_id;
  String nombre;
  PageNivelEdit(this.nivel_id, this.nombre, {Key? key}) : super(key: key);

  @override
  State<PageNivelEdit> createState() => _PageNivelEditState();
}

class _PageNivelEditState extends State<PageNivelEdit> {
  int currentStep = 0;
  TextEditingController nivel_idCtrl = TextEditingController();
  TextEditingController nombreNivelCtrl = TextEditingController();
  TextEditingController detallesCtrl = TextEditingController();
  String errNombre = '', errorDetalles = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Editar Perfil de ${widget.nombre}"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: NivelesProvider().getNivel(widget.nivel_id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          nombreNivelCtrl.text = data['nombreNivel'];
          detallesCtrl.text = data['detalles'];

          return Padding(
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
                            controller: nombreNivelCtrl,
                            decoration: InputDecoration(
                              labelText: 'Nombre del Nivel',
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
                        if (errNombre != "")
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            color: Colors.red,
                            child: Text(
                              errNombre,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: TextFormField(
                            controller: detallesCtrl,
                            decoration: InputDecoration(
                              labelText: 'Detalles',
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
                        if (errorDetalles != "")
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            color: Colors.red,
                            child: Text(
                              errNombre,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Container(
                          child: ElevatedButton(
                            child: Text('Editar Nivel'),
                            onPressed: () async {
                              var respuesta =
                                  await NivelesProvider().UpdateNivel(
                                widget.nivel_id,
                                nombreNivelCtrl.text.trim(),
                                detallesCtrl.text.trim(),
                              );
                              if (respuesta['message'] != null) {
                                // NOMBRE
                                if (respuesta['errors']['nombreNivel'] !=
                                    null) {
                                  errNombre =
                                      respuesta['errors']['nombreNivel'][0];
                                }
                                // DETALLES
                                if (respuesta['errors']['detalles'] != null) {
                                  errorDetalles =
                                      respuesta['errors']['detalles'][0];
                                }
                                setState(() {});
                                return;
                              }
                              print(respuesta);
                              Navigator.pop(context);
                              String nombre = nombreNivelCtrl.text.trim();
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message: '$nombre fue editado exitosamente.',
                                  backgroundColor: Colors.green,
                                  icon: Icon(
                                    Icons.sentiment_very_satisfied,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
