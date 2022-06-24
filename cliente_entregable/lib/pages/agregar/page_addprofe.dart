import 'package:flutter/material.dart';

class PageAddProfe extends StatefulWidget {
  PageAddProfe({Key? key}) : super(key: key);

  @override
  State<PageAddProfe> createState() => _PageAddProfeState();
}

class _PageAddProfeState extends State<PageAddProfe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Profesor'),
      ),
    );
  }
}