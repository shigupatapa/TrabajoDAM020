import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:flutter/material.dart';

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
  TextEditingController sexoCtrl = TextEditingController();
  TextEditingController apoderadoCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  TextEditingController telefono1Ctrl = TextEditingController();
  TextEditingController telefono2Ctrl = TextEditingController();
  TextEditingController alergiasCtrl = TextEditingController();

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
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
              fit: BoxFit.cover),
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
                var respuesta = await NinosProvider().AddNino(
                  rutNinoCtrl.text.trim(),
                  nombreCtrl.text.trim(),
                  sexoCtrl.text.trim(),
                  DateTime.now(),
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
              // int stock = int.tryParse(stockCtrl.text) ?? 0;
              // int precio = int.tryParse(precioCtrl.text) ?? 0;

              // await NinosProvider().AddNino(
              //   codigoCtrl.text.trim(),
              //   nombreCtrl.text.trim(),
              //   stock,
              //   precio,
              // );

              //
              //
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
                        child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                        onPressed: controls.onStepContinue,
                      ),
                    ),
                    SizedBox(width: 12),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('BACK'),
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

  List<Step> getSteps() => [
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
              TextFormField(
                controller: sexoCtrl,
                decoration: InputDecoration(
                  hintText: 'Sexo',
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
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('data2'),
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
          title: Text('data3'),
          content: Container(),
        )
      ];
}
