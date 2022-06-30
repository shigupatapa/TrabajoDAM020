import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PageAddNino extends StatefulWidget {
  PageAddNino({Key? key}) : super(key: key);

  @override
  State<PageAddNino> createState() => _PageAddNinoState();
}

class _PageAddNinoState extends State<PageAddNino> {
  int currentStep = 0;
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
  bool subirImagen = false;

  String errRUT = '';
  String errNombre = '';
  String errSexo = '';
  String errNivel = '';
  String errFecha = '';
  String errTutor = '';
  String errTelUno = '';
  String errTelDos = '';
  String errAlergias = '';

  File? imagen = null;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Agregar Niño"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
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
            child: Stepper(
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () async {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  // send data to server
                  int nivel = int.tryParse(nivelSel) ?? 0;
                  var data = {
                    'rutNino': rutNinoCtrl.text.trim(),
                    'nombreCompleto': nombreCtrl.text.trim(),
                    'sexo': sexo,
                    'fechaNacimiento': hoy.toString(),
                    'nombreApoderado': apoderadoCtrl.text.trim(),
                    'nivel_id': nivel.toString(),
                    'telefono1': telefono1Ctrl.text.trim(),
                    'telefono2': telefono2Ctrl.text.trim(),
                    'alergias': alergiasCtrl.text.trim(),
                  };
                  var respuesta =
                      await NinosProvider().postDataImagen(data, imagenPath);
                  // if (respuesta['message'] != null) {
                  //   // STEP
                  //   if ((respuesta['errors']['rutNino'] != null) ||
                  //       (respuesta['errors']['nombreCompleto'] != null) ||
                  //       (respuesta['errors']['sexo'] != null) ||
                  //       (respuesta['errors']['nivel_id'] != null) ||
                  //       (respuesta['errors']['fechaNacimiento'] != null)) {
                  //     currentStep = 0;
                  //   } else {
                  //     currentStep = 1;
                  //   }
                  //   // RUT
                  //   if (respuesta['errors']['rutNino'] != null) {
                  //     errRUT = respuesta['errors']['rutNino'][0];
                  //   }
                  //   // NOMBRE
                  //   if (respuesta['errors']['nombreCompleto'] != null) {
                  //     errNombre = respuesta['errors']['nombreCompleto'][0];
                  //   }
                  //   // SEXO
                  //   if (respuesta['errors']['sexo'] != null) {
                  //     errSexo = respuesta['errors']['sexo'][0];
                  //   }
                  //   // NIVEL
                  //   if (respuesta['errors']['nivel_id'] != null) {
                  //     errNivel = respuesta['errors']['nivel_id'][0];
                  //   }
                  //   // FECHA NACIMIENTO
                  //   if (respuesta['errors']['fechaNacimiento'] != null) {
                  //     errFecha = respuesta['errors']['fechaNacimiento'][0];
                  //   }
                  //   // TUTOR
                  //   if (respuesta['errors']['nombreApoderado'] != null) {
                  //     errTutor = respuesta['errors']['nombreApoderado'][0];
                  //   }
                  //   // TELEFONO 1
                  //   if (respuesta['errors']['telefono1'] != null) {
                  //     errTelUno = respuesta['errors']['telefono1'][0];
                  //   }
                  //   // TELEFONO 2
                  //   if (respuesta['errors']['telefono2'] != null) {
                  //     errTelDos = respuesta['errors']['telefono2'][0];
                  //   }
                  //   // ALERGIAS
                  //   if (respuesta['errors']['alergias'] != null) {
                  //     errAlergias = respuesta['errors']['alergias'][0];
                  //   }
                  //   setState(() {});
                  //   return;
                  // }
                  setState(() {});
                  print(respuesta);
                  Navigator.pop(context);
                  String nombre = nombreCtrl.text.trim().split(' ').first;
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      message: '$nombre fue agregado exitosamente.',
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
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              controlsBuilder: (context, controls) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(isLastStep ? 'CONFIRMAR' : 'SIGUIENTE'),
                          onPressed: controls.onStepContinue,
                        ),
                      ),
                      SizedBox(width: 12),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            child: Text('REGRESAR'),
                            onPressed: controls.onStepCancel,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text('Datos Básicos'),
        content: Column(
          children: [
            // RUT NIÑO
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
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
            ),
            if (errRUT != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errRUT,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Divider(),
            // NOMBRE NIÑO
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
                ),
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
                    onChanged: (genero) {
                      setState(() {
                        sexo = genero!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    groupValue: sexo,
                    title: Text('Femenino'),
                    value: 'F',
                    onChanged: (genero) {
                      setState(() {
                        sexo = genero!;
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
            // NIVEL NIÑO
            Container(
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

                    items: niveles.map<DropdownMenuItem<String>>((nivel) {
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
            if (errNivel != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errNivel,
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
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Datos Adicionales'),
        content: Column(
          children: [
            // TUTOR NIÑO
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
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
            ),
            if (errTutor != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errTutor,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            Divider(),
            // TELEFONO Nº1 NIÑO
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
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
            ),
            if (errTelUno != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errTelUno,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Divider(),
            // TELEFONO Nº2 NIÑO
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
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
            ),
            if (errTelDos != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errTelDos,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Divider(),
            // ALERGIAS NIÑO
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
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
            ),
            if (errAlergias != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errAlergias,
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
      Step(
          isActive: currentStep >= 2,
          title: Text('Cargar Imagen'),
          content: Container(
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(MdiIcons.image),
                            label: Text('Selecionar una Imagen'),
                            onPressed: () async {
                              var pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                if (pickedFile != null) {
                                  imagen = File(pickedFile.path);
                                  imagenPath = pickedFile.path;
                                  subirImagen = true;
                                }
                              });
                            },
                          ),
                          SizedBox(height: 30),
                          imagen == null ? Center() : Image.file(imagen!),
                        ]),
                  )))),
      Step(
        isActive: currentStep >= 3,
        title: Text('Información'),
        content: Container(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RUT
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'RUT: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: rutNinoCtrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // NOMBRE
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Nombre: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: nombreCtrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SEXO
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sexo: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (sexo == "M")
                          TextSpan(
                            text: "Masculino",
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        if (sexo == "F")
                          TextSpan(
                            text: "Femenino",
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // NIVEL
                  FutureBuilder(
                    future: NivelesProvider().getNivel(
                      int.tryParse(nivelSel) ?? 0,
                    ),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            height: 5,
                            width: 5,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var nivel = snapshot.data;
                      return Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Nivel: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: nivel["nombreNivel"],
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // FECHA DE NACIMIENTO
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Cumpleaños: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: DateFormat("dd-MM-yyyy").format(
                            DateTime.parse(hoy.toString()),
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TUTOR
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Tutor: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: apoderadoCtrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TELEFONO 1
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Telefono Nº 1: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: telefono1Ctrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TELEFONO 2
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Telefono Nº 2: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: telefono2Ctrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ALERGIAS
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Alergias: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: alergiasCtrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ];
  }
}
