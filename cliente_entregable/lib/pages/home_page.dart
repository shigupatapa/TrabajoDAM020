import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('App'),
        leading: Icon(
          MdiIcons.android,
          color: Colors.yellow,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: ListView(
          children: [
            ElevatedButton.icon(
              label: Text('Login'),
              icon: Icon(MdiIcons.login),
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
