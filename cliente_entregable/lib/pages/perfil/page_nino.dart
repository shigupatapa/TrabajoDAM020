import 'package:cliente_entregable/pages/provider/nino_provider.dart';
import 'package:flutter/material.dart';

class PerfilNino extends StatefulWidget {
  PerfilNino({Key? key}) : super(key: key);

  @override
  State<PerfilNino> createState() => _PerfilNinoState();
}

class _PerfilNinoState extends State<PerfilNino> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController stockCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();

  String errCodigo = '';
  String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(labelText: 'Código'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCodigo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errNombre,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: stockCtrl,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: precioCtrl,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Producto'),
                  onPressed: () async {
                    int stock = int.tryParse(stockCtrl.text) ?? 0;
                    int precio = int.tryParse(precioCtrl.text) ?? 0;

                    // var respuesta = await NinosProvider().AddNino(
                    //   codigoCtrl.text.trim(),
                    //   nombreCtrl.text.trim(),
                    //   stock,
                    //   precio,
                    // );

                    // if (respuesta['message'] != null) {
                    //   //cod_producto
                    //   if (respuesta['errors']['cod_producto'] != null) {
                    //     errCodigo = respuesta['errors']['cod_producto'][0];
                    //   }

                    //   //nombre
                    //   if (respuesta['errors']['nombre'] != null) {
                    //     errNombre = respuesta['errors']['nombre'][0];
                    //   }

                    //   setState(() {});
                    //   return;
                    // }

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
