import 'package:cliente_entregable/menu_page.dart';
import 'package:cliente_entregable/models/menu_item.dart';
import 'package:cliente_entregable/pages/ninos/page_listninos.dart';
import 'package:cliente_entregable/pages/niveles/page_listniveles.dart';
import 'package:cliente_entregable/pages/noticias/page_listnoticias.dart';
import 'package:cliente_entregable/pages/profesores/page_listprofes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyMenuItem currentItem = MenuItems.noticias;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Algo salio mal.'),
            );
          } else if (!snapshot.hasData) {
            return PageListNoticias();
          } else {
            return ZoomDrawer(
              style: DrawerStyle.defaultStyle,
              borderRadius: 40,
              // angle: -15,
              slideWidth: MediaQuery.of(context).size.width * 0.75,
              showShadow: true,
              shadowLayer1Color: Colors.blue.shade100.withOpacity(0.5),
              shadowLayer2Color: Colors.red.shade300.withOpacity(0.75),
              mainScreen: getScreen(),
              menuScreenWidth: double.infinity,
              menuScreen: Builder(
                builder: (context) {
                  return MenuPage(
                    currentItem: currentItem,
                    onSelectedItem: (item) {
                      setState(() => currentItem = item);
                      ZoomDrawer.of(context)!.close();
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.ninos:
        return PageListNinos();
      case MenuItems.profes:
        return PageListProfes();
      case MenuItems.niveles:
        return PageListNiveles();
      default:
        return PageListNoticias();
    }
  }
}
