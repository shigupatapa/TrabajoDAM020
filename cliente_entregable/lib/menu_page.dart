import 'package:cliente_entregable/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MenuItems {
  static const noticias = MyMenuItem('Noticias', Ionicons.newspaper);
  static const ninos = MyMenuItem('Niños', Icons.face);
  static const profes = MyMenuItem('Educadoras', Ionicons.school);
  static const niveles = MyMenuItem('Niveles', Ionicons.albums);
  static const all = <MyMenuItem>[
    noticias,
    ninos,
    profes,
    niveles,
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
              "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildHead(),
              //Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(flex: 2),
              Text('Salir'),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHead() {
    return DrawerHeader(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/user.png'),
              ),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Celeste Alten',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(MyMenuItem item) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      color: Colors.white.withOpacity(0.85),
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
}
