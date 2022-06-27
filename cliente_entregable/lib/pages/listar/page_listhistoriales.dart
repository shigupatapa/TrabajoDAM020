import 'package:cliente_entregable/provider/historial_provider.dart';
// import 'package:cliente_entregable/widgets/menu_widget.dart';
// import 'package:cliente_entregable/widgets/drawer.dart';
import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import '../perfil/page_listaview(Ver Solamente el Historial).dart';

class PageListHistoriales extends StatefulWidget {
  PageListHistoriales({Key? key}) : super(key: key);

  @override
  State<PageListHistoriales> createState() => _PageListHistorialesState();
}

class _PageListHistorialesState extends State<PageListHistoriales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historiales'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: HistorialesProvider().getAllHistotiales(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var hist = snap.data[index];
                      return Container(
                        color: Colors.purple,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: ListTile(
                              title: Text(hist['titulo']),
                              subtitle: Text('${hist['rutNino']}'),
                              trailing: Text(hist['created_at']),
                              // onTap: () {
                              //   MaterialPageRoute route = MaterialPageRoute(
                              //     builder: (context) {
                              //       return PageHist(hist['nHistorial']);
                              //     },
                              //   );
                              // },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
