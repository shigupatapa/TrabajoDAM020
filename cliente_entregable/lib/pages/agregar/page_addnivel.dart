import 'dart:ui';

import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

class PageAddNivel extends StatefulWidget {
  PageAddNivel({Key? key}) : super(key: key);

  @override
  State<PageAddNivel> createState() => _PageAddNivelState();
}

class _PageAddNivelState extends State<PageAddNivel> {
  int currentStep = 0;
  // final formKey = GlobalKey<FormState>();
  TextEditingController nombreNivelCtrl = TextEditingController();
  TextEditingController detallesCtrl = TextEditingController();

  String errNombre = '';
  String errDetalles = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Agregar Nivel"),
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
                  var respuesta = await NivelesProvider().AddNivel(
                    nombreNivelCtrl.text.trim(),
                    detallesCtrl.text.trim(),
                  );
                  if (respuesta['message'] != null) {
                    // NOMBRE
                    if (respuesta['errors']['nombreNivel'] != null) {
                      errNombre = respuesta['errors']['nombreNivel'][0];
                      currentStep = 0;
                    }
                    // DETALLES
                    if (respuesta['errors']['detalles'] != null) {
                      errDetalles = respuesta['errors']['detalles'][0];
                      currentStep = 0;
                    }
                    setState(() {});
                    return;
                  }
                  print(respuesta);
                  Navigator.pop(context);
                  String nombre = nombreNivelCtrl.text.trim().split(' ').first;
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      message: '$nombre fue agregado exitosamente.',
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
        title: Text('Nombre'),
        content: Column(
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
                ),
              ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: detallesCtrl,
                decoration: InputDecoration(
                  labelText: 'Detalle',
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
            if (errDetalles != "")
              Container(
                margin: EdgeInsets.only(top: 5),
                color: Colors.red,
                child: Text(
                  errDetalles,
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 1,
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
                          text: nombreNivelCtrl.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // DETALLES
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Detalle: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: detallesCtrl.text,
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
