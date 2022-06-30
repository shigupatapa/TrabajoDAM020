import 'package:cliente_entregable/pages/editar/page_editprofe.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:cliente_entregable/provider/profesor_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PerfilProfe extends StatefulWidget {
  String rut;
  PerfilProfe(this.rut, {Key? key}) : super(key: key);

  @override
  State<PerfilProfe> createState() => _PerfilProfeState();
}

class _PerfilProfeState extends State<PerfilProfe> {
  final double coverHeight = 300;
  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: ProfesoresProvider().getProfe(widget.rut),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var profe = snapshot.data;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(profe),
                SizedBox(height: 10),
                buildInfo(profe),
                buildButtons(profe),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTop(profe) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: profileHeight / 2,
          child: Column(
            children: [
              buildProfileImage(),
              SizedBox(height: 10),
              buildName(profe),
            ],
          ),
        ),
        Positioned(
          top: 1.25 * (coverHeight - profileHeight / 2),
          child: buildSubtitle(profe),
        ),
      ],
    );
  }

  Widget buildCoverImage() {
    return Container(
      height: coverHeight,
      color: Color.fromARGB(255, 185, 55, 55).withOpacity(0.85),
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return Container(
      width: profileHeight,
      height: profileHeight,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/profe.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),
    );
  }

  Widget buildName(profe) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Text(
            profe["nombreCompleto"],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildSubtitle(profe) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
      ),
      child: Column(
        children: [
          if (profe["sexo"] == "M")
            Text(
              "Masculino",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          if (profe["sexo"] == "F")
            Text(
              "Femenino",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget buildInfo(profe) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(120, 185, 55, 55),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xE1BB3939),
            width: 2.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xE1BB3939),
                  ),
                ),
                child: Text(
                  "Información Básica",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Divider(color: Colors.black, height: 20),
            // RUT DEL PROFE
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: Color(0xB6BB3939),
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xB6BB3939),
                  width: 2.5,
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'RUT:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                    TextSpan(
                      text: ' ${profe['rutProfesor']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            // NIVEL EDUCACIONAL
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: Color(0xB6BB3939),
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xB6BB3939),
                  width: 2.5,
                ),
              ),
              child: FutureBuilder(
                future: NivelesProvider().getNivel(profe["nivel_id"]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  var nivel = snapshot.data;
                  return Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Nivel:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                        if (nivel["nombreNivel"] != null)
                          TextSpan(
                            // text: ' ${nino['nivel_id']}',
                            text: ' ${nivel["nombreNivel"]}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        if (nivel["nombreNivel"] == null)
                          TextSpan(
                            // text: ' ${nino['nivel_id']}',
                            text: ' Nivel Eliminado',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            // FECHA DE CUMPLEAÑOS
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: Color(0xB6BB3939),
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xB6BB3939),
                  width: 2.5,
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Cumpleaños:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                    TextSpan(
                      text: ' ${DateFormat("dd-MM-yyyy").format(
                        DateTime.parse(
                          profe['fechaNacimiento'],
                        ),
                      )}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(profe) {
    String nombre = profe['nombreCompleto'].toString().split(' ').first;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 235, 70).withOpacity(0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xB6BB3939),
            width: 2.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                side: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit),
                    Text(
                      'Editar\nDocente',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageEditProfe(
                    profe['rutProfesor'],
                    nombre,
                  );
                });
                Navigator.push(context, route).then((value) => setState(() {}));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                side: BorderSide(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete),
                    Text(
                      'Borrar\nDocente',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                confirmDialog(context, nombre).then((confirm) {
                  if (confirm) {
                    ProfesoresProvider().DeleteProfe(profe['rutProfesor']).then(
                      (borradoOk) {
                        if (borradoOk) {
                          Navigator.pop(context);
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: '$nombre fue eliminado del sistema.',
                              backgroundColor: Colors.cyan,
                              icon: Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.black26,
                                size: 120,
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: '$nombre no pudo ser eliminado.',
                            ),
                          );
                        }
                      },
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
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
