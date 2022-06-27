import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../provider/niveles_provider.dart';

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
  String nivelSel = '', sexo = '';
  var ffecha = DateFormat('yyyy-MM-dd');
  DateTime hoy = DateTime.now();
  // String errCodigo = '';
  // String errNombre = '';

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
                var respuesta = await NinosProvider().AddNino(
                  rutNinoCtrl.text.trim(),
                  nombreCtrl.text.trim(),
                  sexo,
                  hoy,
                  apoderadoCtrl.text.trim(),
                  nivel,
                  telefono1Ctrl.text.trim(),
                  telefono2Ctrl.text.trim(),
                  alergiasCtrl.text.trim(),
                );
                print(respuesta);
                Navigator.pop(context);
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
                margin: EdgeInsets.only(top: 50),
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
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Productos'),
    //   ),
    //   body: Form(
    //     key: formKey,
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: ListView(
    //         children: [
    //           TextFormField(
    //             controller: codigoCtrl,
    //             decoration: InputDecoration(labelText: 'Código'),
    //           ),
    //           Container(
    //             width: double.infinity,
    //             child: Text(
    //               errCodigo,
    //               style: TextStyle(color: Colors.red),
    //             ),
    //           ),
    //           TextFormField(
    //             controller: nombreCtrl,
    //             decoration: InputDecoration(labelText: 'Nombre'),
    //           ),
    //           Container(
    //             width: double.infinity,
    //             child: Text(
    //               errNombre,
    //               style: TextStyle(color: Colors.red),
    //             ),
    //           ),
    //           TextFormField(
    //             controller: stockCtrl,
    //             decoration: InputDecoration(labelText: 'Stock'),
    //             keyboardType: TextInputType.number,
    //           ),
    //           TextFormField(
    //             controller: precioCtrl,
    //             decoration: InputDecoration(labelText: 'Precio'),
    //             keyboardType: TextInputType.number,
    //           ),
    //           Container(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               child: Text('Agregar Producto'),
    //               onPressed: () async {
    //                 // int stock = int.tryParse(stockCtrl.text) ?? 0;
    //                 // int precio = int.tryParse(precioCtrl.text) ?? 0;

    //                 // var respuesta = await NinosProvider().AddNino(
    //                 //   codigoCtrl.text.trim(),
    //                 //   nombreCtrl.text.trim(),
    //                 //   stock,
    //                 //   precio,
    //                 // );

    //                 // if (respuesta['message'] != null) {
    //                 //   //cod_producto
    //                 //   if (respuesta['errors']['cod_producto'] != null) {
    //                 //     errCodigo = respuesta['errors']['cod_producto'][0];
    //                 //   }

    //                 //   //nombre
    //                 //   if (respuesta['errors']['nombre'] != null) {
    //                 //     errNombre = respuesta['errors']['nombre'][0];
    //                 //   }

    //                 //   setState(() {});
    //                 //   return;
    //                 // }

    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text('data'),
        content: Column(
          children: [
            TextFormField(
              controller: rutNinoCtrl,
              decoration: InputDecoration(
                hintText: 'RUT del Niño',
                fillColor: Colors.white70,
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
            TextFormField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                hintText: 'Nombre Completo',
                fillColor: Colors.white70,
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
            //wea de sexo
            Column(
              children: [
                RadioListTile<String>(
                  groupValue: sexo,
                  title: Text('niño'),
                  value: 'M',
                  onChanged: (genero) {
                    setState(() {
                      sexo = genero!;
                    });
                  },
                ),
                RadioListTile<String>(
                  groupValue: sexo,
                  title: Text('nina'),
                  value: 'F',
                  onChanged: (genero) {
                    setState(() {
                      sexo = genero!;
                    });
                  },
                ),
              ],
            ),

            Divider(),
            TextFormField(
              controller: apoderadoCtrl,
              decoration: InputDecoration(
                hintText: 'Nombre del Apoderado',
                fillColor: Colors.white70,
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
            Row(
              children: [
                Text('Fecha de nacimiento:', style: TextStyle(fontSize: 16)),
                Text(ffecha.format(hoy),
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Spacer(),
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
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('data2'),
        content: Column(
          children: [
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
                      hintText: 'Nivel',
                      fillColor: Colors.white70,
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
            Divider(),
            TextFormField(
              controller: telefono1Ctrl,
              decoration: InputDecoration(
                hintText: 'Telefono Nº 1',
                fillColor: Colors.white70,
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
            TextFormField(
              controller: telefono2Ctrl,
              decoration: InputDecoration(
                hintText: 'Telefono Nº 2',
                fillColor: Colors.white70,
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
            TextFormField(
              maxLines: 5,
              controller: alergiasCtrl,
              decoration: InputDecoration(
                hintText: 'Alergias',
                fillColor: Colors.white70,
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
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 2,
        title: Text('Información'),
        content: Container(),
      )
    ];
  }
}
