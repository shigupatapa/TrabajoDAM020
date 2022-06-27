import 'package:cliente_entregable/pages/agregar/page_addhistorial.dart';
import 'package:cliente_entregable/provider/nino_provider.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PerfilNino extends StatefulWidget {
  String rut;
  PerfilNino(this.rut, {Key? key}) : super(key: key);

  @override
  State<PerfilNino> createState() => _PerfilNinoState();
}

class _PerfilNinoState extends State<PerfilNino> {
  final double coverHeight = 300;
  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
          future: NinosProvider().getNino(widget.rut),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var nino = snapshot.data;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(nino),
                SizedBox(height: 10),
                buildInfo(nino),
                buildContacto(nino),
                buildButtons(nino),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTop(nino) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: profileHeight / 2,
          child: Column(
            children: [
              buildProfileImage(nino),
              SizedBox(height: 10),
              buildName(nino),
            ],
          ),
        ),
        Positioned(
          top: 1.25 * (coverHeight - profileHeight / 2),
          child: buildSubtitle(nino),
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

  Widget buildProfileImage(nino) {
    return Container(
      width: profileHeight,
      height: profileHeight,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            'http://192.168.138.130:8000/api/niños/imagen/${nino['rutNino']}',
            // 'http://10.0.2.2:8000/api/niños/imagen/${nino['rutNino']}',
            //'http://192.168.100.72:8000/api/niños/imagen/${nino['rutNino']}',
          ),
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

  Widget buildName(nino) {
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
            nino["nombreCompleto"],
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

  Widget buildSubtitle(nino) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
      ),
      child: Column(
        children: [
          if (nino["sexo"] == "M")
            Text(
              "Masculino",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          if (nino["sexo"] == "F")
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

  Widget buildInfo(nino) {
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
            // RUT DEL NIÑO
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
                      text: ' ${nino['rutNino']}',
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
                future: NivelesProvider().getNivel(nino["nivel_id"]),
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
                        TextSpan(
                          // text: ' ${nino['nivel_id']}',
                          text: ' ${nivel["nombreNivel"]}',
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
                          nino['fechaNacimiento'],
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
            SizedBox(height: 5),
            // APODERADO O TUTOR
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
                      text: 'Tutor:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                    TextSpan(
                      text: ' ${nino['nombreApoderado']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            // ALERGIAS
            if (nino['alergias'] != null)
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
                        text: 'Alergias:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                        ),
                      ),
                      TextSpan(
                        text: ' ${nino['alergias']}',
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

  Widget buildContacto(nino) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 70, 135, 255).withOpacity(0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xB6BB3939),
            width: 2.5,
          ),
        ),
        child: Container(
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_android_sharp),
                    Text(
                      'Contacto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black, height: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //if (nino['telefono1'] != null)
                  Container(
                    padding: EdgeInsets.all(2.5),
                    child: Text(
                      'Telefono: ${nino['telefono1']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (nino['telefono2'] != null)
                    Container(
                      padding: EdgeInsets.all(2.5),
                      child: Text(
                        nino['telefono2'],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(nino) {
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
                    Icon(Icons.add),
                    Text(
                      'Agregar\nHistorial',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageAddHistorial(
                      nino['rutNino'], nino['nombreCompleto']);
                });
                Navigator.push(context, route);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
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
                    Icon(Icons.list_alt),
                    Text(
                      'Ver\nHistorial',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                print("You pressed Icon Elevated Button");
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
                      'Borrar\nNiño',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                print("You pressed Icon Elevated Button");
              },
            ),
          ],
        ),
      ),
    );
  }
}
//   return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Perfil del niño'),
//       // ),
//       body: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                   'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000',
//                 ),
//                 fit: BoxFit.cover),
//           ),
//           child: Padding(
//               padding: EdgeInsets.all(10),
//               child: FutureBuilder(
//                 future: NinosProvider().getNino(widget.rut),
//                 builder: ((context, AsyncSnapshot snap) {
//                   if (!snap.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   var data = snap.data;
//                   return CustomScrollView(slivers: <Widget>[
//                     SliverAppBar(
//                       pinned: true,
//                       expandedHeight: 300,
//                       backgroundColor: Color.fromARGB(255, 185, 58, 58),
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: SafeArea(
//                           child: Column(
//                             children: [
//                               //Foto de la persona
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Container(
//                                   height: 200,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         // 'http://10.0.2.2:8000/api/niños/imagen/${data['rutNino']}',
//                                         'http://192.168.100.72:8000/api/niños/imagen/${data['rutNino']}',
//                                       ),
//                                     ),
//                                     border: Border.all(
//                                       color: Colors.blueGrey,
//                                       width: 2.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               //Nombre de la persona y su rut
//                               Text(
//                                 data['nombreCompleto'],
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 30),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverAppBar(
//                       pinned: false,
//                       expandedHeight: 5,
//                       backgroundColor: Color.fromARGB(226, 188, 82, 82),
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: SafeArea(
//                           child: Container(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'Rut: ${data['rutNino']}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 Text(
//                                   'Sexo: ${data['sexo']}',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverFixedExtentList(
//                       itemExtent: 500,
//                       delegate: SliverChildListDelegate(
//                         [
//                           //TODA LA CAJA
//                           Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Expanded(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(121, 187, 57, 57),
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         width: 5,
//                                         color: Color(0xE1BB3939),
//                                       ),
//                                     ),
//                                     //Datos niño
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         //Nombre
//                                         Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xB6BB3939),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 width: 5,
//                                                 color: Color(0xB6BB3939),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Nivel: ${data['nivel_id']} ',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                         //Fecha de Nacimiento
//                                         Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xB6BB3939),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 width: 5,
//                                                 color: Color(0xB6BB3939),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Fecha de Cumpleaños: ${data['fechaNacimiento']} ',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xB6BB3939),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 width: 5,
//                                                 color: Color(0xB6BB3939),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Nombre Tutor: ${data['nombreApoderado']} ',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xB6BB3939),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 width: 5,
//                                                 color: Color(0xB6BB3939),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Alergias: ${data['alergias']} ',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight.bold),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Column(
//                                         children: [
//                                           Icon(Icons.phone_android_sharp),
//                                           Text(
//                                             'Telefono ',
//                                             style: TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Divider(
//                                             color: Colors.black,
//                                             height: 5,
//                                           ),
//                                           Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                             children: [
//                                               Container(
//                                                 alignment:
//                                                     Alignment.centerLeft,
//                                                 decoration: BoxDecoration(
//                                                     //border: Border.all(width: 1),
//                                                     ),
//                                                 child: Text(
//                                                   'Telefono N°1 \n ${data['telefono1']}',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 decoration: BoxDecoration(
//                                                     //border: Border.all(width: 1),
//                                                     ),
//                                                 child: Text(
//                                                   'Telefono N°2 \n ${data['telefono2']}',
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             Color.fromARGB(255, 68, 137, 255),
//                                         borderRadius:
//                                             BorderRadius.circular(5),
//                                         border: Border.all(
//                                           width: 5,
//                                           color: Color(0xB6BB3939),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SliverAppBar(
//                         pinned: true,
//                         expandedHeight: 300,
//                         backgroundColor: Color.fromARGB(0, 185, 58, 58),
//                         flexibleSpace: FlexibleSpaceBar(
//                             background: SafeArea(
//                                 child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                     children: <Widget>[
//                               Flexible(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Card(
//                                   color: Color.fromARGB(189, 244, 67, 54),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Container(
//                                         height: 275,
//                                         alignment: Alignment.centerLeft,
//                                         padding: EdgeInsets.all(20),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 print(
//                                                     "You pressed Icon Elevated Button");
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                   primary: Colors.cyan),
//                                               child: Column(
//                                                 mainAxisSize:
//                                                     MainAxisSize.min,
//                                                 children: [
//                                                   Icon(Icons.add),
//                                                   Text('Agregar Historial'),
//                                                 ],
//                                               ),
//                                             ),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 print(
//                                                     "You pressed Icon Elevated Button");
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                   primary: Colors.green),
//                                               child: Column(
//                                                 mainAxisSize:
//                                                     MainAxisSize.min,
//                                                 children: [
//                                                   Icon(Icons.list_alt),
//                                                   Text('Ver Historial'),
//                                                 ],
//                                               ),
//                                             ),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 print(
//                                                     "You pressed Icon Elevated Button");
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                   primary: Color.fromARGB(
//                                                       255, 116, 55, 51)),
//                                               child: Column(
//                                                 mainAxisSize:
//                                                     MainAxisSize.min,
//                                                 children: [
//                                                   Icon(Icons.auto_delete),
//                                                   Text('Borrar Niño'),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ))
//                             ]))))
//                   ]);
//                 }),
//               ))));
// }
// }
