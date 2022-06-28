import 'package:cliente_entregable/pages/agregar/page_addnino.dart';
import 'package:cliente_entregable/pages/perfil/page_nino.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
// import 'package:cliente_entregable/widgets/drawer.dart';
import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class PageListNinos extends StatefulWidget {
  PageListNinos({Key? key}) : super(key: key);

  @override
  State<PageListNinos> createState() => _PageListNinosState();
}

class _PageListNinosState extends State<PageListNinos> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerPage(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: MenuWidget(),
        title: Text("Niños"),
        centerTitle: true,
        backgroundColor: Colors.black87,
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
          IconButton(
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return PageAddNino();
              });
              Navigator.push(context, route).then((value) => setState(() {}));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
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
        child: FutureBuilder(
          future: NinosProvider().getAllNinos(),
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
    );
  }

  Widget buildList(snap) {
    return isGrid ? buildGridView(snap) : buildListView(snap);
  }

  Widget buildGridView(snap) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        var nino = snap.data[index];
        return Column(
          children: [
            GridTile(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          //'http://192.168.138.130:8000/api/niños/imagen/${nino['rutNino']}',
                          //'http://10.0.2.2:8000/api/niños/imagen/${nino['rutNino']}', // EMULADOR
                          'http://192.168.1.160:8000/api/niños/imagen/${nino['rutNino']}', // ENZO
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) {
                        return PerfilNino(nino['rutNino']);
                      },
                    );
                    Navigator.push(context, route).then((value) => setState(() {}));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black87),
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    nino['nombreCompleto'],
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildListView(snap) {
    return ListView.builder(
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        var nino = snap.data[index];
        return Card(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          color: Colors.white.withOpacity(0.85),
          child: FutureBuilder(
            future: NivelesProvider().getNivel(nino["nivel_id"]),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator()),
                  ),
                );
              }
              var nivel = snapshot.data;
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        //'http://192.168.138.130:8000/api/niños/imagen/${nino['rutNino']}',
                        //'http://10.0.2.2:8000/api/niños/imagen/${nino['rutNino']}', // EMULADOR
                        'http://192.168.1.160:8000/api/niños/imagen/${nino['rutNino']}', // ENZO
                      ),
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
                  nino['nombreCompleto'],
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  // nino['nivel_id'].toString(),
                  nivel["nombreNivel"],
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return PerfilNino(nino['rutNino']);
                  });
                  Navigator.push(context, route).then((value) => setState(() {}));
                },
              );
            },
          ),
        );
      },
    );
  }
}
