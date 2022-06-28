import 'dart:ui';

import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';

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

  // void initState() {
  //   super.initState();

  //   // NivelesProvider().getNivel(widget.nivel_id).then((data) {
  //   //   nivel_idCtrl = data['nivel_id'];
  //   //   nombreNivelCtrl.text = data['nombreNivel'];
  //   //   detallesCtrl.text = data['detalles'];
  //   // });
  //   // print(nombreNivelCtrl.text);
  // }

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
          // nivel_idCtrl = data['nivel_id'].toString();
          nombreNivelCtrl.text = data['nombreNivel'];
          detallesCtrl.text = data['detalles'];
          // print(nombreNivelCtrl.text);
          return Container(
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
                  currentStep: currentStep,
                  onStepContinue: () async {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      print(nombreNivelCtrl.text);
                      // send data to server
                      var respuesta = await NivelesProvider().UpdateNivel(
                        widget.nivel_id,
                        nombreNivelCtrl.text.trim(),
                        detallesCtrl.text.trim(),
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
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child:
                                  Text(isLastStep ? 'CONFIRMAR' : 'SIGUIENTE'),
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
                  steps: getSteps(),
                ),
              ),
            ),
          );
        },
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
                print(nombreNivelCtrl.text);
              },
            ),
            Divider(),
            TextFormField(
              controller: detallesCtrl,
              decoration: InputDecoration(
                hintText: 'Detalles',
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
      // Step(
      //   isActive: currentStep >= 1,
      //   title: Text('Información'),
      //   content: Container(),
      // )
    ];
  }
}
