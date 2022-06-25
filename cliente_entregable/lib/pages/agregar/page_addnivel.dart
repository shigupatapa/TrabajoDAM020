import 'package:cliente_entregable/provider/niveles_provider.dart';
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

  // String errCodigo = '';
  // String errNombre = '';

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
                "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
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
                var respuesta = await NivelesProvider().AddNivel(
                  nombreNivelCtrl.text.trim(),
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
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Nombre'),
          content: Column(
            children: [
              TextFormField(
                controller: nombreNivelCtrl,
                decoration: InputDecoration(
                  hintText: 'Nombre del Nivel',
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
          isActive: currentStep >= 1,
          title: Text('Información'),
          content: Container(),
        )
      ];
}
