import 'package:cliente_entregable/provider/profesor_provider.dart';
import 'package:flutter/material.dart';

class PageAddProfe extends StatefulWidget {
  PageAddProfe({Key? key}) : super(key: key);

  @override
  State<PageAddProfe> createState() => _PageAddProfeState();
}

class _PageAddProfeState extends State<PageAddProfe> {
  int currentStep = 0;
  // final formKey = GlobalKey<FormState>();
  TextEditingController rutProfeCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();

  // String errCodigo = '';
  // String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Agregar Educadora"),
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
                int nivel = int.tryParse(nivelCtrl.text) ?? 0;
                var respuesta = await ProfesoresProvider().AddProfe(
                  rutProfeCtrl.text.trim(),
                  nombreCtrl.text.trim(),
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
    );
  }

  List<Step> getSteps() => [
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
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Nivel'),
          content: Column(
            children: [
              TextFormField(
                controller: nivelCtrl,
                decoration: InputDecoration(
                  hintText: 'Nivel',
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
