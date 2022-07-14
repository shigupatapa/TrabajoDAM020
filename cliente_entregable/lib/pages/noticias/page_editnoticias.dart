import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../provider/noticias_service.dart';

class PageEditNoticia extends StatefulWidget {
  String id;
  PageEditNoticia(this.id, {Key? key}) : super(key: key);

  @override
  State<PageEditNoticia> createState() => _PageEditNoticiaState();
}

TextEditingController tituloCtrl = TextEditingController();
TextEditingController contenidoCtrl = TextEditingController();
DateTime currentPhoneDate = DateTime.now(); //DateTime

Timestamp fecha = Timestamp.fromDate(currentPhoneDate);

class _PageEditNoticiaState extends State<PageEditNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Noticias'),
        ),
        body: Form(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: FutureBuilder(
                future: FirestoreService().getNoticia(widget.id),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data;
                  tituloCtrl.text = data['titulo'];
                  contenidoCtrl.text = data['contenido'];

                  return ListView(children: [
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
                        child: Text('Editar'),
                        onPressed: () {
                          String titulo = tituloCtrl.text.trim();
                          String contenido = contenidoCtrl.text.trim();
                          FirestoreService().noticiaEditar(
                              widget.id, titulo, contenido, fecha);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ]);
                }),
          ),
        ));
  }
}
