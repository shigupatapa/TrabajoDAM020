import 'package:cliente_entregable/pages/editar/page_editnivel.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PerfilNivel extends StatefulWidget {
  int idNivel;
  PerfilNivel(this.idNivel, {Key? key}) : super(key: key);

  @override
  State<PerfilNivel> createState() => _PerfilNivelState();
}

class _PerfilNivelState extends State<PerfilNivel> {
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
          future: NivelesProvider().getNivel(widget.idNivel),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var nivel = snapshot.data;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(nivel),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildNinos(),
                      buildProfes(),
                    ],
                  ),
                ),
                buildButtons(nivel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTop(nivel) {
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
              buildName(nivel),
            ],
          ),
        ),
        Positioned(
          top: 1.25 * (coverHeight - profileHeight / 2),
          child: buildSubtitle(nivel),
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
        //   child: Image.network(
        //     'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000',
        //     width: double.infinity,
        //     height: coverHeight,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }

  Widget buildProfileImage() {
    return Container(
      width: profileHeight,
      height: profileHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/nivel.png'),
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

  Widget buildName(nivel) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                nivel["nombreNivel"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSubtitle(nivel) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
      ),
      child: Text(
        nivel['detalles'],
        style: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildNinos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Niños del Nivel",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder(
                future: NivelesProvider().getNinosbyNivel(widget.idNivel),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: LinearProgressIndicator(),
                    );
                  }
                  return buildListNino(snap);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListNino(snap) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        var ninos = snap.data[index];
        bool imgExiste = true;
        if (ninos['imagen'] == null) {
          imgExiste = false;
        }
        if (imgExiste) {
          return ListTile(
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    //'http://192.168.138.130:8000/api/niños/imagen/${ninos['rutNino']}',
                    //'http://10.0.2.2:8000/api/niños/imagen/${ninos['rutNino']}', // EMULADOR
                    'http://192.168.1.160:8000/api/niños/imagen/${ninos['rutNino']}', // ENZO
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(
              ninos['nombreCompleto'],
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListTile(
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(
              ninos['nombreCompleto'],
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }

  Widget buildProfes() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Educadoras del Nivel",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder(
                future: NivelesProvider().getProfesbyNivel(widget.idNivel),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: LinearProgressIndicator(),
                    );
                  }
                  return buildListProfes(snap);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListProfes(snap) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 5),
      itemCount: snap.data.length,
      itemBuilder: (context, index) {
        var profes = snap.data[index];
        return ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profe.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            profes['nombreCompleto'],
            style: TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget buildButtons(nivel) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
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
                      'Editar\nNivel',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return PageNivelEdit(widget.idNivel);
                });
                Navigator.push(context, route);
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
                      'Borrar\nNivel',
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
