import 'dart:ui';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PageEditNino extends StatefulWidget {
  String rut;
  String nombre;
  PageEditNino(this.rut, this.nombre, {Key? key}) : super(key: key);

  @override
  State<PageEditNino> createState() => _PageEditNinoState();
}

class _PageEditNinoState extends State<PageEditNino> {
  // final formKey = GlobalKey<FormState>();
  TextEditingController rutNinoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apoderadoCtrl = TextEditingController();
  TextEditingController telefono1Ctrl = TextEditingController();
  TextEditingController telefono2Ctrl = TextEditingController();
  TextEditingController alergiasCtrl = TextEditingController();
  TextEditingController imagenCtrl = TextEditingController();
  String nivelSel = '', sexo = '', imagenPath = '';
  var ffecha = DateFormat('dd-MM-yyyy');
  DateTime hoy = DateTime.now();
  bool editar = false;

  // String errCodigo = '';
  // String errNombre = '';
  @override
  void initState() {
    super.initState();
    NinosProvider().getNino(widget.rut).then((data) {
      rutNinoCtrl.text = data['rutNino'];
      nombreCtrl.text = data['nombreCompleto'];
      apoderadoCtrl.text = data['nombreApoderado'];
      telefono1Ctrl.text = data['telefono1'];
      if (data['telefono2'] != null) {
        telefono2Ctrl.text = data['telefono2'];
      }
      if (data['alergias'] != null) {
        alergiasCtrl.text = data['alergias'];
      }
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
                child: ListView(
                  children: [
                    // RUT NIÑO
                    TextFormField(
                      readOnly: !editar,
                      controller: rutNinoCtrl,
                      decoration: InputDecoration(
                        labelText: 'RUT del Niño',
                        fillColor: Colors.white.withOpacity(0.9),
                        filled: true,
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      //limita los carracteres
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      onChanged: (String text) {
                        //RUTValidator.formatFromTextController(rutNinoCtrl);
                      },
                      keyboardType: TextInputType.number,
                    ),

                    Container(
                      child: Row(
                        children: [
                          Text('Editar Rut? '),
                          Checkbox(
                              value: editar,
                              onChanged: (bool? value) {
                                setState(() {
                                  rutNinoCtrl.text = widget.rut;
                                  editar = value!;
                                });
                              })
                        ],
                      ),
                    ),
                    Divider(),
                    // NOMBRE NIÑO
                    TextFormField(
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
                    Divider(),
                    // SEXO NIÑO
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
                              style: TextStyle(fontSize: 16),
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
                    Divider(),
                    // TUTOR NIÑO
                    TextFormField(
                      controller: apoderadoCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nombre del Apoderado',
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
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ffecha.format(hoy),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                    Divider(),
                    // NIVEL NIÑO
                    Container(
                      width: double.infinity,
                      child: FutureBuilder(
                        future: NivelesProvider().getAllNiveles(),
                        builder: (context, AsyncSnapshot snap) {
                          if (!snap.hasData) {
                            return DropdownButtonFormField<String>(
                              hint: Text('Cargando niveles...'),
                              value: nivelSel,
                              items: [],
                              onChanged: (valor) {},
                            );
                          }
                          var niveles = snap.data;
                          return DropdownButtonFormField<String>(
                            //hint: Text('Nivel'),
                            decoration: InputDecoration(
                              hintText: 'Nivel',
                              fillColor: Colors.white.withOpacity(0.9),
                              filled: true,
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),

                            items:
                                niveles.map<DropdownMenuItem<String>>((nivel) {
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
                    ),
                    Divider(),
                    // TELEFONO Nº1 NIÑO
                    TextFormField(
                      controller: telefono1Ctrl,
                      decoration: InputDecoration(
                        labelText: 'Telefono Nº 1',
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
                      keyboardType: TextInputType.number,
                    ),
                    Divider(),
                    // TELEFONO Nº2 NIÑO
                    TextFormField(
                      controller: telefono2Ctrl,
                      decoration: InputDecoration(
                        labelText: 'Telefono Nº 2',
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
                      keyboardType: TextInputType.number,
                    ),
                    Divider(),
                    // ALERGIAS NIÑO
                    TextFormField(
                      maxLines: 5,
                      controller: alergiasCtrl,
                      decoration: InputDecoration(
                        labelText: 'Alergias',
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
                    Divider(),
                    Container(
                      child: ElevatedButton(
                        child: Text('Editar Niño'),
                        onPressed: () async {
                          int nivel = int.tryParse(nivelSel) ?? 0;

                          var respuesta = await NinosProvider().UpdateNino(
                            editar,
                            widget.rut,
                            rutNinoCtrl.text.trim(),
                            nombreCtrl.text.trim(),
                            sexo,
                            hoy.toString(),
                            apoderadoCtrl.text.trim(),
                            nivel,
                            telefono1Ctrl.text.trim(),
                            telefono2Ctrl.text.trim(),
                            alergiasCtrl.text.trim(),
                          );
                          print(respuesta);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    )
                  ],
                )

                // Stepper(
                //   type: StepperType.vertical,
                //   steps: getSteps(),
                //   currentStep: currentStep,
                //   onStepContinue: () async {
                //     final isLastStep = currentStep == getSteps().length - 1;
                //     if (isLastStep) {
                //       // send data to server
                //       int nivel = int.tryParse(nivelSel) ?? 0;
                //       var respuesta = await NinosProvider().UpdateNino(
                //         widget.rut,
                //         rutNinoCtrl.text.trim(),
                //         nombreCtrl.text.trim(),
                //         sexo,
                //         hoy,
                //         apoderadoCtrl.text.trim(),
                //         nivel,
                //         telefono1Ctrl.text.trim(),
                //         telefono2Ctrl.text.trim(),
                //         alergiasCtrl.text.trim(),
                //       );
                //       print(respuesta);
                //       Navigator.pop(context);
                //     } else {
                //       setState(() => currentStep += 1);
                //     }
                //   },
                //   onStepTapped: (step) => setState(() => currentStep = step),
                //   onStepCancel: currentStep == 0
                //       ? null
                //       : () => setState(() => currentStep -= 1),
                //   controlsBuilder: (context, controls) {
                //     final isLastStep = currentStep == getSteps().length - 1;
                //     return Container(
                //       margin: EdgeInsets.only(top: 10),
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: ElevatedButton(
                //               child: Text(isLastStep ? 'CONFIRMAR' : 'SIGUIENTE'),
                //               onPressed: controls.onStepContinue,
                //             ),
                //           ),
                //           SizedBox(width: 12),
                //           if (currentStep != 0)
                //             Expanded(
                //               child: ElevatedButton(
                //                 child: Text('REGRESAR'),
                //                 onPressed: controls.onStepCancel,
                //               ),
                //             ),
                //         ],
                //       ),
                //     );
                //   },
                // ),

                ),
          ),
        ),
      ),
    );
  }

//   List<Step> getSteps() {
//     return [
//       Step(
//         state: currentStep > 0 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 0,
//         title: Text('data'),
//         content: Column(
//           children: [],
//         ),
//       ),
//       Step(
//         state: currentStep > 1 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 1,
//         title: Text('data2'),
//         content: Column(
//           children: [
//             // NIVEL NIÑO
//             Container(
//               width: double.infinity,
//               child: FutureBuilder(
//                 future: NivelesProvider().getAllNiveles(),
//                 builder: (context, AsyncSnapshot snap) {
//                   if (!snap.hasData) {
//                     return DropdownButtonFormField<String>(
//                       hint: Text('Cargando niveles...'),
//                       items: [],
//                       onChanged: (valor) {},
//                     );
//                   }
//                   var niveles = snap.data;
//                   return DropdownButtonFormField<String>(
//                     //hint: Text('Nivel'),
//                     decoration: InputDecoration(
//                       hintText: 'Nivel',
//                       fillColor: Colors.white.withOpacity(0.9),
//                       filled: true,
//                       contentPadding: EdgeInsets.all(15),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),

//                     items: niveles.map<DropdownMenuItem<String>>((nivel) {
//                       return DropdownMenuItem<String>(
//                         child: Text(nivel['nombreNivel']),
//                         value: nivel['nivel_id'].toString(),
//                       );
//                     }).toList(),
//                     value: nivelSel.isEmpty ? null : nivelSel,
//                     onChanged: (nuevoNivel) {
//                       setState(() {
//                         nivelSel = nuevoNivel.toString();
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             // TELEFONO Nº1 NIÑO
//             TextFormField(
//               controller: telefono1Ctrl,
//               decoration: InputDecoration(
//                 hintText: 'Telefono Nº 1',
//                 fillColor: Colors.white.withOpacity(0.9),
//                 filled: true,
//                 contentPadding: EdgeInsets.all(15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onChanged: (value) {
//                 // do something
//               },
//               keyboardType: TextInputType.number,
//             ),
//             Divider(),
//             // TELEFONO Nº2 NIÑO
//             TextFormField(
//               controller: telefono2Ctrl,
//               decoration: InputDecoration(
//                 hintText: 'Telefono Nº 2',
//                 fillColor: Colors.white.withOpacity(0.9),
//                 filled: true,
//                 contentPadding: EdgeInsets.all(15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onChanged: (value) {
//                 // do something
//               },
//               keyboardType: TextInputType.number,
//             ),
//             Divider(),
//             // ALERGIAS NIÑO
//             TextFormField(
//               maxLines: 5,
//               controller: alergiasCtrl,
//               decoration: InputDecoration(
//                 hintText: 'Alergias',
//                 fillColor: Colors.white.withOpacity(0.9),
//                 filled: true,
//                 contentPadding: EdgeInsets.all(15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onChanged: (value) {
//                 // do something
//               },
//             ),
//           ],
//         ),
//       ),
//       Step(
//         isActive: currentStep >= 2,
//         title: Text('Información'),
//         content: Container(
//           child: Column(
//             children: [
//               ElevatedButton.icon(
//                   icon: Icon(MdiIcons.camera),
//                   label: Text('subir imagen'),
//                   onPressed: () {})
// //               ESTA COSA NO FUNCIONA!!!!!
// //               (path == null ) ? Container() : Image.file(File(path),width: 200,),
// //               RaisedButton(
// //               child: Text("CARGAR IMAGEN"),
// //                 onPressed: () async {
// //                 final ImagePicker _picker = ImagePicker();
// //                 PickedFile _archivo = await _picker.getImage(source: ImageSource.gallery);
// // ....

// //                 setState(() {
// //                   _ruta =_archivo.path;
// //                 });
// //             }),
// //             /// enviar al servidor web
// //             RaisedButton(
// //               child: Text("ENVIAR AL SERVIDOR"),
// //                 onPressed: (){
// //               _enviarform();
// //             })
//             ],
//           ),
//         ),
//       )
//     ];
//   }
}
