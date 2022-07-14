import 'package:flutter/material.dart';

class PageEditNoticia extends StatefulWidget {
  PageEditNoticia({Key? key}) : super(key: key);

  @override
  State<PageEditNoticia> createState() => _PageEditNoticiaState();
}

class _PageEditNoticiaState extends State<PageEditNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
    );
  }
}
