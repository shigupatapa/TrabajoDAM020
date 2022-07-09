import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class PageListNoticias extends StatefulWidget {
  PageListNoticias({Key? key}) : super(key: key);

  @override
  State<PageListNoticias> createState() => _PageListNoticiasState();
}

class _PageListNoticiasState extends State<PageListNoticias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: MenuWidget(),
        title: Text('Noticias'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
    );
  }
}
