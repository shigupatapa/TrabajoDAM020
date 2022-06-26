import 'package:flutter/material.dart';

class PerfilNino extends StatefulWidget {
  PerfilNino({Key? key}) : super(key: key);

  @override
  State<PerfilNino> createState() => _PerfilNinoState();
}

class _PerfilNinoState extends State<PerfilNino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000'),
              fit: BoxFit.cover),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: Color.fromARGB(255, 185, 58, 58),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Column(
                    children: [
                      //Foto de la persona
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/user.png'),
                            ),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      //Nombre de la persona y su rut
                      Text(
                        'Hubert Blaine Wolfeschlegelsteinhausenbergerdorff Sr.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              pinned: false,
              expandedHeight: 5,
              backgroundColor: Color.fromARGB(226, 188, 82, 82),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          'Rut: 121231230',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Sexo: Helicoptero de ataque',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 500,
              delegate: SliverChildListDelegate(
                [
                  //TODA LA CAJA
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(121, 187, 57, 57),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 5,
                                color: Color(0xE1BB3939),
                              ),
                            ),
                            //Datos niño
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Nombre
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xB6BB3939),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 5,
                                        color: Color(0xB6BB3939),
                                      ),
                                    ),
                                    child: Text(
                                      'Nivel:  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                //Fecha de Nacimiento
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xB6BB3939),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 5,
                                        color: Color(0xB6BB3939),
                                      ),
                                    ),
                                    child: Text(
                                      'Fecha de Cumpleaños:  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xB6BB3939),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 5,
                                        color: Color(0xB6BB3939),
                                      ),
                                    ),
                                    child: Text(
                                      'Nombre Tutor:  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xB6BB3939),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 5,
                                        color: Color(0xB6BB3939),
                                      ),
                                    ),
                                    child: Text(
                                      'Alergias:  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(Icons.phone_android_sharp),
                                  Text(
                                    'Telefono ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            //border: Border.all(width: 1),
                                            ),
                                        child: Text(
                                          'Telefono N°1 \n +56 9 5696 9999',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                            //border: Border.all(width: 1),
                                            ),
                                        child: Text(
                                          'Telefono N°2 \n +56 9 5696 9999',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 68, 137, 255),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 5,
                                  color: Color(0xB6BB3939),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: Color.fromARGB(0, 185, 58, 58),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color.fromARGB(189, 244, 67, 54),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 275,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          print(
                                              "You pressed Icon Elevated Button");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.cyan),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.add),
                                            Text('Agregar\nHistorial'),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print(
                                              "You pressed Icon Elevated Button");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.list_alt),
                                            Text('Ver\nHistorial'),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print(
                                              "You pressed Icon Elevated Button");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 116, 55, 51)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.auto_delete),
                                            Text('Borrar\nNiño'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
