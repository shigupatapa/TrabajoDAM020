// ASSETS //
/* flutter pub add ionicons */

/* https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg */

////////////

import 'package:cliente_entregable/menu_page.dart';
import 'package:cliente_entregable/models/menu_item.dart';
import 'package:cliente_entregable/pages/listar/page_listninos.dart';
import 'package:cliente_entregable/pages/listar/page_listniveles.dart';
import 'package:cliente_entregable/pages/listar/page_listprofes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyMenuItem currentItem = MenuItems.ninos;

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
      child: ZoomDrawer(
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
        return PageListNinos();
      //   return PageListHistoriales();
    }
  }
}
