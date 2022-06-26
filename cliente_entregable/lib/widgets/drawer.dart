import 'package:cliente_entregable/pages/listar/page_listhistoriales.dart';
import 'package:cliente_entregable/pages/listar/page_listninos.dart';
import 'package:cliente_entregable/pages/listar/page_listniveles.dart';
import 'package:cliente_entregable/pages/listar/page_listprofes.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(
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
                  return PageListHistoriales();
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
    );
  }
}
