// ASSETS //
/* flutter pub add ionicons */

/* https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg */

////////////

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        backgroundColor: Colors.red,
        title: Text('Aplicacion de Jardin'),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(30)),
            ListTile(
              leading: Icon(Icons.face),
              title: const Text('Niños'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.school),
              title: const Text('Educadoras'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.book),
              title: const Text('Historiales'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.albums),
              title: const Text('Niveles'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
