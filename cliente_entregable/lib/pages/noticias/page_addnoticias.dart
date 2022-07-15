import 'dart:ui';

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
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Form(
            child: Padding(
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
                              colorScheme:
                                  ColorScheme.light(primary: Colors.black87),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
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
                                    child: Text('Agregar noticia'),
                                    onPressed: () {
                                      String titulo = tituloCtrl.text.trim();
                                      String contenido =
                                          contenidoCtrl.text.trim();
                                      FirestoreService().noticiaAgregar(
                                          titulo, contenido, fecha);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ]),
                            )))))));
  }
}
