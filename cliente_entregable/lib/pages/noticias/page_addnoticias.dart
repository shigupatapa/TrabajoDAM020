import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../provider/noticias_service.dart';

class PageAddNoticia extends StatefulWidget {
  PageAddNoticia({Key? key}) : super(key: key);

  @override
  State<PageAddNoticia> createState() => _PageAddNoticiaState();
}

TextEditingController tituloCtrl = TextEditingController();
TextEditingController contenidoCtrl = TextEditingController();
DateTime currentPhoneDate = DateTime.now(); //DateTime

Timestamp fecha = Timestamp.fromDate(currentPhoneDate);

class _PageAddNoticiaState extends State<PageAddNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar noticia'),
        ),
        body: Form(
            child: Padding(
          padding: EdgeInsets.all(12),
          child: ListView(children: [
            TextFormField(
              controller: tituloCtrl,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            Divider(),
            TextFormField(
              controller: contenidoCtrl,
              decoration: InputDecoration(labelText: 'Contenido'),
              maxLines: 3,
            ),
            Divider(),

            /// la wea de la fecha
            Divider(),
            Container(
              child: ElevatedButton(
                child: Text('Agregar noticia'),
                onPressed: () {
                  String titulo = tituloCtrl.text.trim();
                  String contenido = contenidoCtrl.text.trim();
                  FirestoreService().noticiaAgregar(titulo, contenido, fecha);
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        )));
  }
}
