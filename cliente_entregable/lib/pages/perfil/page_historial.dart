import 'package:cliente_entregable/pages/editar/page_edithistorial.dart';
import 'package:cliente_entregable/provider/historial_provider.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:cool_alert/cool_alert.dart';
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
  bool showContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Historial de ${widget.nombre}'),
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
            return Padding(
              padding: EdgeInsets.all(10),
              child: buildListView(snap),
            );
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
        var fecha = DateFormat("dd-MM-yyyy HH:mm").format(
            DateTime.parse(hist['created_at']).subtract(Duration(hours: 4)));
        return Column(
          children: [
            Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        hist['titulo'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        fecha,
                        textAlign: TextAlign.center,
                      ),
                      trailing: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(showContent
                            ? Icons.keyboard_double_arrow_up
                            : Icons.keyboard_double_arrow_down),
                        onPressed: () {
                          setState(() {
                            showContent = !showContent;
                          });
                        },
                      ),
                      onTap: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return PageEditHistorial(
                            hist['nHistorial'],
                            widget.rut,
                            hist['titulo'],
                          );
                        });
                        Navigator.push(context, route)
                            .then((value) => setState(() {}));
                      },
                    ),
                    showContent
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 5,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    hist['contenido'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      confirmDialog(context, hist['titulo'])
                                          .then(
                                        (confirm) {
                                          if (confirm) {
                                            HistorialesProvider()
                                                .DeleteHistorial(
                                                    hist['nHistorial'])
                                                .then(
                                              (borradoOk) {
                                                if (borradoOk) {
                                                  snap.data.removeAt(index);
                                                  setState(() {});
                                                  showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.info(
                                                      message:
                                                          '${hist['titulo']} fue eliminado del sistema.',
                                                      backgroundColor:
                                                          Colors.cyan,
                                                      icon: Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black26,
                                                        size: 120,
                                                      ),
                                                      textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.error(
                                                      message:
                                                          '${hist['titulo']} no pudo ser eliminado.',
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  confirmDialog(BuildContext context, String nombre) {
    return CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      title: 'Confirmar Borrado',
      text: '¿Borrar a $nombre?',
      confirmBtnText: 'Aceptar',
      confirmBtnColor: Colors.green,
      confirmBtnTextStyle: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      onConfirmBtnTap: () => Navigator.pop(context, true),
      cancelBtnText: 'Cancelar',
      showCancelBtn: true,
      cancelBtnTextStyle: TextStyle(
        fontSize: 15,
      ),
      onCancelBtnTap: () => Navigator.pop(context, false),
    );
  }
}
