import 'package:cliente_entregable/pages/editar/page_edithistorial.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PageHistorial extends StatefulWidget {
  String rut;
  String nombre;
  PageHistorial(this.rut, this.nombre, {Key? key}) : super(key: key);

  @override
  State<PageHistorial> createState() => _PageHistorialState();
}

class _PageHistorialState extends State<PageHistorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Historiales'),
        centerTitle: true,
        backgroundColor: Colors.black87,
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
          future: NinosProvider().getHistorial(widget.rut),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snap.data);
            return Padding(
              padding: EdgeInsets.all(5),
              child: buildListView(snap),
            );
            // return ListView.separated(
            //   separatorBuilder: (_, __) => Divider(),
            //   itemCount: snap.data.length,
            //   itemBuilder: (context, index) {
            //     var hist = snap.data[index];
            //     return Container(
            //       color: Colors.purple,
            //       child: Padding(
            //         padding: EdgeInsets.all(8),
            //         child: Container(
            //           padding: EdgeInsets.only(right: 10),
            //           alignment: Alignment.centerRight,
            //           color: Colors.red,
            //           child: ListTile(
            //             title: Text(hist['titulo']),
            //             subtitle: Text('${hist['rutNino']}'),
            //             trailing: Text(hist['created_at']),
            //             // onTap: () {
            //             //   MaterialPageRoute route = MaterialPageRoute(
            //             //     builder: (context) {
            //             //       return PageHist(hist['nHistorial']);
            //             //     },
            //             //   );
            //             // },
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }

  Widget buildListView(snap) {
    return ListView.builder(
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        var hist = snap.data[index];
        return Card(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          color: Colors.white.withOpacity(0.85),
          child: ListTile(
            title: Text(
              hist['titulo'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              '${DateFormat("dd-MM-yyyy - hh:mm").format(
                DateTime.parse(
                  hist['created_at'],
                ),
              )}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return PageEditHistorial(hist['nivel_id'], hist['rutNino']);
              });
              Navigator.push(context, route).then((value) => setState(() {}));
            },
          ),
        );
      },
    );
  }
}
