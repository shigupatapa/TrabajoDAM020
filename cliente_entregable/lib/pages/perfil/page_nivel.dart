import 'package:cliente_entregable/pages/editar/page_editnivel.dart';
import 'package:cliente_entregable/provider/niveles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildNinos(),
                      buildProfes(),
                    ],
                  ),
                ),
              ],
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
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
            label: 'Editar',
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return PageNivelEdit();
              });
              Navigator.push(context, route).then((value) => setState(() {}));
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            label: 'Borrar',
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return PageNivelEdit();
              });
              Navigator.push(context, route).then((value) => setState(() {}));
            },
          ),
        ],
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
        //   // child: Image.network(
        //   //   'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000',
        //   //   width: double.infinity,
        //   //   height: coverHeight,
        //   //   fit: BoxFit.cover,
        //   // ),
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
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
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
                      // 'http://10.0.2.2:8000/api/niños/imagen/${ninos['rutNino']}',
                      'http://192.168.100.72:8000/api/niños/imagen/${ninos['rutNino']}'),
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
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
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
}
