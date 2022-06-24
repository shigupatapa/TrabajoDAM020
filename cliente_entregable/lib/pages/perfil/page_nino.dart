// import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:flutter/material.dart';

class PerfilNino extends StatefulWidget {
  PerfilNino({Key? key}) : super(key: key);

  @override
  State<PerfilNino> createState() => _PerfilNinoState();
}

class _PerfilNinoState extends State<PerfilNino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil Niño'),
      ),
    );
  }
}
