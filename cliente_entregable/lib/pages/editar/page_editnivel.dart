import 'package:flutter/material.dart';

class PageNivelEdit extends StatefulWidget {
  PageNivelEdit({Key? key}) : super(key: key);

  @override
  State<PageNivelEdit> createState() => _PageNivelEditState();
}

class _PageNivelEditState extends State<PageNivelEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
    );
  }
}
