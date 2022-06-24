import 'package:cliente_entregable/pages/agregar/page_addprofe.dart';
import 'package:cliente_entregable/pages/perfil/page_nino.dart';
import 'package:cliente_entregable/provider/profesor_provider.dart';
import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PageListProfes extends StatefulWidget {
  PageListProfes({Key? key}) : super(key: key);

  @override
  State<PageListProfes> createState() => _PageListProfesState();
}

class _PageListProfesState extends State<PageListProfes> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: MenuWidget(),
        title: Text("Profesores"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (isGrid == true) {
                isGrid = false;
              } else {
                isGrid = true;
              }
              setState(() {});
            },
            icon: Icon(
              isGrid == true ? Icons.grid_off : Icons.grid_on,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: ProfesoresProvider().getAllProfes(),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.all(5),
              child: buildList(snap),
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        buttonSize: Size(50, 50),
        childrenButtonSize: Size(50, 50),
        backgroundColor: Colors.black87,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Agregar',
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return PageAddProfe();
              });
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }

  Widget buildList(snap) => isGrid
      ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: snap.data.length,
          itemBuilder: (context, index) {
            var profes = snap.data[index];
            return GridTile(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  child: Image.network(
                    'http://i.imgur.com/QSev0hg.jpg',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) {
                        return PerfilNino();
                      },
                    );
                    Navigator.push(context, route);
                  },
                ),
              ),
              footer: Card(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black87),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text(
                      profes['nombreCompleto'],
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      : ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (context, index) {
            var profes = snap.data[index];
            return Card(
              shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              color: Colors.white60,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                title: Text(
                  profes['nombreCompleto'],
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  profes['nivel_id'].toString(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return PerfilNino();
                  });
                  Navigator.push(context, route);
                },
              ),
            );
          },
        );
}
