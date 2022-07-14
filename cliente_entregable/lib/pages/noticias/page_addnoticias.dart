import 'package:flutter/material.dart';

class PageAddNoticia extends StatefulWidget {
  PageAddNoticia({Key? key}) : super(key: key);

  @override
  State<PageAddNoticia> createState() => _PageAddNoticiaState();
}

class _PageAddNoticiaState extends State<PageAddNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar'),
      ),
    );
  }
}