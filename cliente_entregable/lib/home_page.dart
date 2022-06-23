// ASSETS //
/* flutter pub add ionicons */

/* https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg */

////////////

import 'package:cliente_entregable/pages/listar/page_listhistoriales.dart';
import 'package:cliente_entregable/pages/listar/page_listninos.dart';
import 'package:cliente_entregable/pages/listar/page_listniveles.dart';
import 'package:cliente_entregable/pages/listar/page_listprofes.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageListNinos();
                });
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.school),
              title: const Text('Educadoras'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageListProfes();
                });
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.book),
              title: const Text('Historiales'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PagelistHistoriales();
                });
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Ionicons.albums),
              title: const Text('Niveles'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageListNiveles();
                });
                Navigator.push(context, route);
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
