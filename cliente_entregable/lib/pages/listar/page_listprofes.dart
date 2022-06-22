import 'package:flutter/material.dart';

import '../provider/profesor_provider.dart';

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
      appBar: AppBar(
        title: Text("Listado de Profesores"),
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
      body: Column(
        children: [
          FutureBuilder(
            future: ProductosProvider().getAllProfes(),
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
            var ninos = snap.data[index];
            return GridTile(
              child: Image.network(
                'http://i.imgur.com/QSev0hg.jpg',
                fit: BoxFit.cover,
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
            );
          },
        );
}
