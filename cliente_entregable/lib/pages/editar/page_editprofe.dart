import 'dart:ui';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:cliente_entregable/provider/profesor_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PageEditProfe extends StatefulWidget {
  String rut;
  String nombre;
  PageEditProfe(this.rut, this.nombre, {Key? key}) : super(key: key);

  @override
  State<PageEditProfe> createState() => _PageEditProfeState();
}

class _PageEditProfeState extends State<PageEditProfe> {
  // final formKey = GlobalKey<FormState>();
  TextEditingController rutProfeCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  String nivelSel = '', sexo = '';
  var ffecha = DateFormat('dd-MM-yyyy');
  DateTime hoy = DateTime.now();
  bool editar = false;
  String errRUT = '',
      errNombre = '',
      errSexo = '',
      errFecha = '',
      errNivel = '';

  @override
  void initState() {
    super.initState();
    ProfesoresProvider().getProfe(widget.rut).then((data) {
      rutProfeCtrl.text = data['rutProfesor'];
      nombreCtrl.text = data['nombreCompleto'];
      sexo = data['sexo'];
      hoy = DateTime.parse(data['fechaNacimiento']);
      nivelSel = data['nivel_id'].toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Editar Perfil de ${widget.nombre}"),
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
                    // RUT
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        readOnly: !editar,
                        controller: rutProfeCtrl,
                        decoration: InputDecoration(
                          labelText: 'RUT del Docente',
                          fillColor: Colors.white.withOpacity(0.9),
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (String text) {
                          //RUTValidator.formatFromTextController(rutProfeCtrl);
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    if (errRUT != "")
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.red,
                        child: Text(
                          errRUT,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         '¿Desea editar el RUT? ',
                    //         style: TextStyle(
                    //           backgroundColor: Colors.yellow,
                    //         ),
                    //       ),
                    //       Checkbox(
                    //         value: editar,
                    //         onChanged: (bool? value) {
                    //           setState(() {
                    //             rutProfeCtrl.text = widget.rut;
                    //             editar = value!;
                    //           });
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Divider(),
                    // NOMBRE
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: nombreCtrl,
                        decoration: InputDecoration(
                          labelText: 'Nombre Completo',
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
                    // SEXO
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Sexo:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          RadioListTile<String>(
                            groupValue: sexo,
                            title: Text('Masculino'),
                            value: 'M',
                            onChanged: (value) {
                              setState(() {
                                sexo = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            groupValue: sexo,
                            title: Text('Femenino'),
                            value: 'F',
                            onChanged: (value) {
                              setState(() {
                                sexo = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    if (errSexo != "")
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.red,
                        child: Text(
                          errSexo,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    Divider(),
                    // FECHA DE NACIMIENTO NIÑO
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Fecha de Nacimiento:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ffecha.format(hoy),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                child: Icon(MdiIcons.calendar),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1920),
                                    lastDate: DateTime.now(),
                                    locale: Locale('es', 'ES'),
                                  ).then((fecha) {
                                    setState(() {
                                      hoy = fecha ?? hoy;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (errFecha != "")
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.red,
                        child: Text(
                          errFecha,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    Divider(),
                    // NIVEL
                    FutureBuilder(
                      future: NivelesProvider()
                          .getNivel(int.tryParse(nivelSel) ?? 0),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        var data = snapshot.data.toString();
                        if (data == '{}') {
                          nivelSel = "";
                        }
                        return Container(
                          width: double.infinity,
                          child: FutureBuilder(
                            future: NivelesProvider().getAllNiveles(),
                            builder: (context, AsyncSnapshot snap) {
                              if (!snap.hasData) {
                                return DropdownButtonFormField<String>(
                                  hint: Text('Cargando niveles...'),
                                  items: [],
                                  onChanged: (valor) {},
                                );
                              }
                              var niveles = snap.data;
                              return DropdownButtonFormField<String>(
                                //hint: Text('Nivel'),
                                decoration: InputDecoration(
                                  labelText: 'Nivel',
                                  fillColor: Colors.white.withOpacity(0.9),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                                items: niveles
                                    .map<DropdownMenuItem<String>>((nivel) {
                                  return DropdownMenuItem<String>(
                                    child: Text(nivel['nombreNivel']),
                                    value: nivel['nivel_id'].toString(),
                                  );
                                }).toList(),
                                value: nivelSel.isEmpty ? null : nivelSel,
                                onChanged: (nuevoNivel) {
                                  setState(() {
                                    nivelSel = nuevoNivel.toString();
                                  });
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    if (errNivel != "")
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Colors.red,
                        child: Text(
                          errNivel,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Divider(),
                    Container(
                      child: ElevatedButton(
                        child: Text('Editar Profesor'),
                        onPressed: () async {
                          int nivel = int.tryParse(nivelSel) ?? 0;

                          var respuesta =
                              await ProfesoresProvider().UpdateProfe(
                            editar,
                            widget.rut,
                            rutProfeCtrl.text.trim(),
                            nombreCtrl.text.trim(),
                            sexo,
                            hoy.toString(),
                            nivel,
                          );
                          if (respuesta['message'] != null) {
                            // RUT
                            if (respuesta['errors']['rutProfesor'] != null) {
                              errRUT = respuesta['errors']['rutProfesor'][0];
                            }
                            // NOMBRE
                            if (respuesta['errors']['nombreCompleto'] != null) {
                              errNombre =
                                  respuesta['errors']['nombreCompleto'][0];
                            }
                            // SEXO
                            if (respuesta['errors']['sexo'] != null) {
                              errSexo = respuesta['errors']['sexo'][0];
                            }
                            // FECHA NACIMIENTO
                            if (respuesta['errors']['fechaNacimiento'] !=
                                null) {
                              errFecha =
                                  respuesta['errors']['fechaNacimiento'][0];
                            }
                            // NIVEL
                            if (respuesta['errors']['nivel_id'] != null) {
                              errNivel = respuesta['errors']['nivel_id'][0];
                            }
                            setState(() {});
                            return;
                          }
                          print(respuesta);
                          Navigator.pop(context);
                          String nombre =
                              nombreCtrl.text.trim().split(' ').first;
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
      ),
    );
  }
}
