import 'package:flutter/material.dart';

class PageAddNivel extends StatefulWidget {
  PageAddNivel({Key? key}) : super(key: key);

  @override
  State<PageAddNivel> createState() => _PageAddNivelState();
}

class _PageAddNivelState extends State<PageAddNivel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nivel'),
      ),
    );
  }
}