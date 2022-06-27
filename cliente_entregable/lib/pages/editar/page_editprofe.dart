import 'dart:ui';

import 'package:cliente_entregable/provider/profesor_provider.dart';
import 'package:flutter/material.dart';

import '../../provider/niveles_provider.dart';

class PageEditProfe extends StatefulWidget {
  String rut;
  PageEditProfe(this.rut, {Key? key}) : super(key: key);

  @override
  State<PageEditProfe> createState() => _PageEditProfeState();
}

class _PageEditProfeState extends State<PageEditProfe> {
  int currentStep = 0;
  // final formKey = GlobalKey<FormState>();
  TextEditingController rutProfeCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  String nivelSel = '', sexo = '';

  // String errCodigo = '';
  // String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Editar Educadora"),
        centerTitle: true,
        backgroundColor: Colors.green,
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
                  int nivel = int.tryParse(nivelCtrl.text) ?? 0;
                  var respuesta = await ProfesoresProvider().UpdateProfe(
                    widget.rut,
                    rutProfeCtrl.text.trim(),
                    nombreCtrl.text.trim(),
                    sexo,
                    DateTime.now(),
                    nivel,
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
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text('Personal'),
        content: Column(
          children: [
            TextFormField(
              controller: rutProfeCtrl,
              decoration: InputDecoration(
                hintText: 'RUT del Docente',
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
                child: Column(children: [
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
                    onChanged: (genero) {
                      setState(() {
                        sexo = genero!;
                      });
                    },
                  ),
                ]))
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Nivel'),
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
