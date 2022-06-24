import 'package:flutter/material.dart';

class PageAddHistorial extends StatefulWidget {
  PageAddHistorial({Key? key}) : super(key: key);

  @override
  State<PageAddHistorial> createState() => _PageAddHistorialState();
}

class _PageAddHistorialState extends State<PageAddHistorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Historial'),
      ),
    );
  }
}
