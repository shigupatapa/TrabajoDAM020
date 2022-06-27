import 'dart:ui';
import 'package:cliente_entregable/provider/historial_provider.dart';
import 'package:flutter/material.dart';

class PageAddHistorial extends StatefulWidget {
  String rut;
  PageAddHistorial(this.rut, {Key? key}) : super(key: key);

  @override
  State<PageAddHistorial> createState() => _PageAddHistorialState();
}

class _PageAddHistorialState extends State<PageAddHistorial> {
  int currentStep = 0;
  DateTime date = DateTime.now();
  TextEditingController rutNinoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Historial'),
        centerTitle: true,
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
                  var rutNino = widget.rut;
                  var titulo = tituloCtrl.text.trim();
                  var contenido = contenidoCtrl.text.trim();
                  var respuesta = await HistorialesProvider()
                      .AddHistorial(rutNino, titulo, date, contenido);

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
          title: Text('Agregar historial'),
          content: Column(children: [
            // RUT NIÑO
            // TextFormField(
            //   controller: rutNinoCtrl,
            //   decoration: InputDecoration(
            //     hintText: 'RUT del Niño',
            //     fillColor: Colors.white.withOpacity(0.9),
            //     filled: true,
            //     contentPadding: EdgeInsets.all(15),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            //   onChanged: (value) {
            //     // do something
            //   },
            //   keyboardType: TextInputType.number,
            // ),
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
            Divider(),
            TextFormField(
                maxLines: 6,
                controller: contenidoCtrl,
                decoration: InputDecoration(
                  hintText: 'Alergias',
                  fillColor: Colors.white.withOpacity(0.9),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {
                  // do something
                })
          ]))
    ];
  }
}
