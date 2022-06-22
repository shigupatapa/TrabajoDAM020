import 'package:cliente_entregable/pages/perfil/page_nino.dart';
import 'package:cliente_entregable/pages/provider/nino_provider.dart';
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
      appBar: AppBar(
        title: Text("Listado de Niños"),
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
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
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
            var ninos = snap.data[index];
            return GridTile(
              child: InkWell(
                child: Image.network(
                  'http://i.imgur.com/QSev0hg.jpg',
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return PerfilNino();
                  });
                  Navigator.push(context, route);
                },
              ),
              footer: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    ninos['nombreCompleto'],
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        )
      : ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (context, index) {
            var ninos = snap.data[index];
            return ListTile(
              // leading: CircleAvatar(
              //   radius: 28,
              //   backgroundImage: NetworkImage(
              //       'https://www.kindacode.com/wp-content/uploads/2021/12/sample-leaf.jpeg'),
              // ),
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
                ninos['nombreCompleto'],
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                ninos['nivel'].toString(),
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PerfilNino();
                });
                Navigator.push(context, route);
              },
            );
          },
        );
}

            // return ListView.separated(
            //   separatorBuilder: (_, __) => Divider(),
            //   itemCount: snap.data.length,
            //   itemBuilder: (context, index) {
            //     var prod = snap.data[index];
            //     // return ListTile(
            //     //   // leading: Icon(MdiIcons.cube),
            //     //   title: Text(prod['nombreCompleto']),
            //     // );
            //     return Card(
            //       color: Colors.red,
            //       child: Text(prod['nombreCompleto']),
            //     );
            //   },