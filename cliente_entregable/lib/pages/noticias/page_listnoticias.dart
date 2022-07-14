import 'dart:math';

import 'package:cliente_entregable/login_page.dart';
import 'package:cliente_entregable/pages/noticias/page_addnoticias.dart';
import 'package:cliente_entregable/provider/noticias_service.dart';
import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class PageListNoticias extends StatefulWidget {
  PageListNoticias({Key? key}) : super(key: key);

  @override
  State<PageListNoticias> createState() => _PageListNoticiasState();
}

class _PageListNoticiasState extends State<PageListNoticias> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Algo salio mal.'),
          );
        } else {
          var userAuth = snapshot.data;
          //print(userAuth);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: userAuth != null ? MenuWidget() : null,
              title: Text('Noticias'),
              centerTitle: true,
              backgroundColor: Colors.black87,
              actions: [
                if (userAuth == null)
                  IconButton(
                    onPressed: () {
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      });
                      Navigator.push(context, route)
                          .then((value) => setState(() {}));
                    },
                    icon: Icon(Ionicons.log_in),
                  ),
                if (userAuth != null)
                  IconButton(
                    onPressed: () {
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (context) {
                        return PageAddNoticia();
                      });
                      Navigator.push(context, route)
                          .then((value) => setState(() {}));
                    },
                    icon: Icon(Icons.add),
                  ),
              ],
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
              child: StreamBuilder(
                stream: FirestoreService().noticias(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: buildList(snapshot, userAuth),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildList(snapshot, userAuth) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var noticia = snapshot.data!.docs[index];
        DateTime dt = (noticia['fecha'] as Timestamp).toDate();
        var fecha = DateFormat("dd-MM-yyyy HH:mm")
            .format(DateTime.parse(dt.toString()));
        return Container(
          height: 250,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Card(
            elevation: 5,
            child: GridTile(
              header: GridTileBar(
                backgroundColor: Colors.white,
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profe.png'),
                ),
                title: Text(
                  '${noticia['titulo']}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${fecha}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Image.network(
                    'https://www.kindacode.com/wp-content/uploads/2021/12/sample-leaf.jpeg',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    //top: 75,
                    //left: 125,
                    child: Container(
                      height: 300,
                      color: Colors.black54,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          '${noticia['contenido']}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              footer: GridTileBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                    ),
                    SizedBox(width: 2),
                    Text(
                      Random().nextInt(100).toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 2),
                    Text(
                      Random().nextInt(20).toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: userAuth != null
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.purple,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          )
                        ],
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
