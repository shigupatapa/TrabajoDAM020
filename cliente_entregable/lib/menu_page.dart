import 'package:cliente_entregable/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MenuItems {
  static const ninos = MyMenuItem('Niños', Icons.face);
  static const profes = MyMenuItem('Educadoras', Ionicons.school);
  static const niveles = MyMenuItem('Niveles', Ionicons.albums);
  static const historiales = MyMenuItem('Historiales', Ionicons.book);
  static const all = <MyMenuItem>[
    ninos,
    profes,
    niveles,
    historiales,
  ];
}

class MenuPage extends StatelessWidget {
  final MyMenuItem currentItem;
  final ValueChanged<MyMenuItem> onSelectedItem;

  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MyMenuItem item) => Card(
        shape: RoundedRectangleBorder(),
        color: Colors.white60,
        child: ListTile(
          selectedTileColor: Colors.green.shade400,
          selectedColor: Colors.black87,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );
}
