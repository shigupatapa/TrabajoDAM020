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
  final double coverHeight = 200;
  final double profileHeight = 120;

  // @override
  // void initState() {
  //   super.initState();
  // }

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
              "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg",
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
                buildTop(),
                SizedBox(height: 5),
                buildName(nivel),
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
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCoverImage() {
    return Container(
      // color: Colors.grey,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        child: Image.network(
          'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    // return CircleAvatar(
    //   // backgroundColor: Colors.grey.shade800,
    //   radius: profileHeight / 2,
    //   backgroundImage: AssetImage('assets/images/user.png'),
    // );

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/nivel.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(profileHeight / 2)),
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
              // Text(
              //   "Nombre",
              //   style: TextStyle(
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        ),
        // SizedBox(height: 5),
        // Container(
        //   padding: EdgeInsets.all(5),
        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(0.85),
        //     borderRadius: BorderRadius.all(Radius.circular(50)),
        //     border: Border.all(
        //       color: Colors.black,
        //       width: 1,
        //     ),
        //   ),
        //   child: Text(
        //     "Nombre",
        //     style: TextStyle(
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget buildNinos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.all(Radius.circular(50)),
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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.all(Radius.circular(50)),
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

  // Widget buildAbout() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     padding: EdgeInsets.symmetric(horizontal: 20),
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //           color: Colors.black,
  //           width: 1,
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(50)),
  //       ),
  //       color: Colors.transparent,
  //       child: Container(
  //         padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
  //         decoration: BoxDecoration(
  //           color: Colors.white.withOpacity(0.85),
  //           borderRadius: BorderRadius.all(Radius.circular(50)),
  //           border: Border.all(
  //             color: Colors.black,
  //             width: 1,
  //           ),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Acerca de",
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               "Pellentesque nisl est, pulvinar et purus in, feugiat consectetur velit. Mauris vitae lobortis purus. Praesent ut commodo leo. Donec vitae facilisis odio. Maecenas bibendum ligula at eros facilisis, ut interdum augue lacinia. Proin egestas bibendum ante, id vestibulum urna varius quis. Nullam aliquam suscipit semper. Cras nec porta felis. Cras porttitor ornare mauris, eget ultrices nunc sollicitudin ut. Aenean sed egestas mauris. Morbi pharetra nibh congue quam fermentum sodales. Maecenas lacus velit, faucibus ac lorem a, tristique aliquam tellus. Sed viverra nunc eget interdum varius. Vestibulum sit amet fringilla tortor. Curabitur vitae est id diam tincidunt dapibus ac at risus. Ut vel nisl metus.Pellentesque nisl est, pulvinar et purus in, feugiat consectetur velit. Mauris vitae lobortis purus. Praesent ut commodo leo. Donec vitae facilisis odio. Maecenas bibendum ligula at eros facilisis, ut interdum augue lacinia. Proin egestas bibendum ante, id vestibulum urna varius quis. Nullam aliquam suscipit semper. Cras nec porta felis. Cras porttitor ornare mauris, eget ultrices nunc sollicitudin ut. Aenean sed egestas mauris. Morbi pharetra nibh congue quam fermentum sodales. Maecenas lacus velit, faucibus ac lorem a, tristique aliquam tellus. Sed viverra nunc eget interdum varius. Vestibulum sit amet fringilla tortor. Curabitur vitae est id diam tincidunt dapibus ac at risus. Ut vel nisl metus.",
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
