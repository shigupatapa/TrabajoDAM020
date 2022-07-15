import 'dart:ui';

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
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child: Container(
                // height: double.infinity,
                // width: double.infinity,
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
                      child: Container(
                        padding: EdgeInsets.all(10),
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

                              return Form(
                                child: ListView(children: [
                                  TextFormField(
                                    controller: tituloCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'Titulo',
                                      fillColor: Colors.white.withOpacity(0.9),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  TextFormField(
                                    controller: contenidoCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'Contenido',
                                      fillColor: Colors.white.withOpacity(0.9),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    maxLines: 10,
                                  ),
                                  Divider(),

                                  /// la wea de la fecha
                                  //Divider(),
                                  Container(
                                    child: ElevatedButton(
                                      child: Text('Editar'),
                                      onPressed: () {
                                        String titulo = tituloCtrl.text.trim();
                                        String contenido =
                                            contenidoCtrl.text.trim();
                                        FirestoreService().noticiaEditar(
                                            widget.id,
                                            titulo,
                                            contenido,
                                            fecha);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ]),
                              );
                            }),
                      ),
                    )))));
  }
}
