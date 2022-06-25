import 'package:flutter/material.dart';

class PerfilNino extends StatefulWidget {
  PerfilNino({Key? key}) : super(key: key);

  @override
  State<PerfilNino> createState() => _PerfilNinoState();
}

class _PerfilNinoState extends State<PerfilNino> {
  List<Widget> Botones = [
    RotatedBox(
      quarterTurns: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Icon(Icons.article_outlined),
      ),
    ),
    Spacer(),
    RotatedBox(
      quarterTurns: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Icon(Icons.library_add_sharp),
      ),
    ),
    Spacer(),
    RotatedBox(
      quarterTurns: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Icon(Icons.face_retouching_off),
      ),
    ),

    /*
    ButtonBar(
      children: [
        Container(
          height: 100,
          width: 100,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: RotatedBox(
            quarterTurns: 5,
            child: IconButton(
              icon: Icon(Icons.list, color: Colors.white),
              onPressed: () async {
                //callback function when back button is pressed
                exit(0);
              },
            ),
          ),
        ),
      ],
    ),
    ButtonBar(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
          ),
          child: RotatedBox(
            quarterTurns: 5,
            child: IconButton(
              icon: Icon(Icons.wysiwyg_sharp, color: Colors.white),
              onPressed: null,
            ),
          ),
        ),
      ],
    ),
    ButtonBar(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: RotatedBox(
            quarterTurns: 5,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: null,
            ),
          ),
        ),
      ],
    ),*/
    /*
    ListTile(
      leading: Icon(Icons.local_activity, size: 100),
      title: Text('Activity'),
      subtitle: Text('Description here'),
    ),
    ListTile(
      leading: Transform.rotate(
        angle: -math.pi / 3,
        child: IconButton(
          icon: Icon(Icons.local_airport, size: 100),
          onPressed: () {},
        ),
      ),
      title: Text('Airport'),
      subtitle: Text('Description here'),
    ),
    ListTile(
      leading: Icon(Icons.local_atm, size: 100),
      title: Text('ATM'),
      subtitle: Text('Description here'),
    )*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              backgroundColor:
                  Color.fromARGB(255, 185, 55, 55).withOpacity(0.95),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Column(
                    children: [
                      // FOTO DEL PERFIL
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: AssetImage('assets/image/user.jpg'),
                            // ),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      // NOMBRE Y RUT
                      Text(
                        'Hubert Blaine Wolfeschlegelstein Sr.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
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
            // SliverList(delegate: delegate),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(120, 185, 55, 55),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 5,
                              color: Color(0xE1BB3939),
                            ),
                          ),

                          // DATOS NIÑO
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // NIVEL
                              Padding(
                                padding: EdgeInsets.all(10),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // FECHA NACIMIENTO
                              Padding(
                                padding: EdgeInsets.all(10),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // TUTOR DEL NIÑO
                              Padding(
                                padding: EdgeInsets.all(10),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // ALERGIAS
                              Padding(
                                padding: EdgeInsets.all(10),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Icon(Icons.phone_android_sharp),
                                Text(
                                  'Telefono ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
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
                ],
              ),
            ),
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      alignment: Alignment.center,
                      child: ListWheelScrollView(
                        magnification: 2,
                        itemExtent: 100,
                        children: Botones,
                        // children: [],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // // child: CustomScrollView(
        // //   slivers: <Widget>[
        // //
        // //
        // //     SliverFixedExtentList(
        // //       itemExtent: 500,
        // //       delegate: SliverChildListDelegate(
        // //         [
        // //           //TODA LA CAJA
        // //           Padding(
        // //             padding: EdgeInsets.all(10.0),
        // //             child: Expanded(
        // //               child: Column(
        // //                 children: [
        // //                   Container(
        // //                     alignment: Alignment.centerLeft,
        // //                     decoration: BoxDecoration(
        // //                       color: Color.fromARGB(121, 187, 57, 57),
        // //                       borderRadius: BorderRadius.circular(5),
        // //                       border: Border.all(
        // //                         width: 5,
        // //                         color: Color(0xE1BB3939),
        // //                       ),
        // //                     ),
        // //                     //Datos niño
        // //                     child: Column(
        // //                       crossAxisAlignment: CrossAxisAlignment.start,
        // //                       children: [
        // //                         //Nombre
        // //                         Padding(
        // //                           padding: EdgeInsets.all(8.0),
        // //                           child: Container(
        // //                             decoration: BoxDecoration(
        // //                               color: Color(0xB6BB3939),
        // //                               borderRadius: BorderRadius.circular(5),
        // //                               border: Border.all(
        // //                                 width: 5,
        // //                                 color: Color(0xB6BB3939),
        // //                               ),
        // //                             ),
        // //                             child: Text(
        // //                               'Nivel:  ',
        // //                               style: TextStyle(
        // //                                   fontSize: 20,
        // //                                   fontWeight: FontWeight.bold),
        // //                             ),
        // //                           ),
        // //                         ),
        // //                         //Fecha de Nacimiento
        // //                         Padding(
        // //                           padding: EdgeInsets.all(8.0),
        // //                           child: Container(
        // //                             decoration: BoxDecoration(
        // //                               color: Color(0xB6BB3939),
        // //                               borderRadius: BorderRadius.circular(5),
        // //                               border: Border.all(
        // //                                 width: 5,
        // //                                 color: Color(0xB6BB3939),
        // //                               ),
        // //                             ),
        // //                             child: Text(
        // //                               'Fecha de Cumpleaños:  ',
        // //                               style: TextStyle(
        // //                                   fontSize: 20,
        // //                                   fontWeight: FontWeight.bold),
        // //                             ),
        // //                           ),
        // //                         ),
        // //                         Padding(
        // //                           padding: EdgeInsets.all(8.0),
        // //                           child: Container(
        // //                             decoration: BoxDecoration(
        // //                               color: Color(0xB6BB3939),
        // //                               borderRadius: BorderRadius.circular(5),
        // //                               border: Border.all(
        // //                                 width: 5,
        // //                                 color: Color(0xB6BB3939),
        // //                               ),
        // //                             ),
        // //                             child: Text(
        // //                               'Nombre Tutor:  ',
        // //                               style: TextStyle(
        // //                                   fontSize: 20,
        // //                                   fontWeight: FontWeight.bold),
        // //                             ),
        // //                           ),
        // //                         ),
        // //                         Padding(
        // //                           padding: EdgeInsets.all(8.0),
        // //                           child: Container(
        // //                             decoration: BoxDecoration(
        // //                               color: Color(0xB6BB3939),
        // //                               borderRadius: BorderRadius.circular(5),
        // //                               border: Border.all(
        // //                                 width: 5,
        // //                                 color: Color(0xB6BB3939),
        // //                               ),
        // //                             ),
        // //                             child: Text(
        // //                               'Alergias:  ',
        // //                               style: TextStyle(
        // //                                   fontSize: 20,
        // //                                   fontWeight: FontWeight.bold),
        // //                             ),
        // //                           ),
        // //                         ),
        // //                       ],
        // //                     ),
        // //                   ),
        // //                   Padding(
        // //                     padding: const EdgeInsets.all(10.0),
        // //                     child: Container(
        // //                       padding: EdgeInsets.all(8.0),
        // //                       child: Column(
        // //                         children: [
        // //                           Icon(Icons.phone_android_sharp),
        // //                           Text(
        // //                             'Telefono ',
        // //                             style: TextStyle(
        // //                                 fontSize: 20,
        // //                                 fontWeight: FontWeight.bold),
        // //                           ),
        // //                           Divider(
        // //                             color: Colors.black,
        // //                             height: 5,
        // //                           ),
        // //                           Row(
        // //                             mainAxisSize: MainAxisSize.max,
        // //                             mainAxisAlignment:
        // //                                 MainAxisAlignment.spaceBetween,
        // //                             children: [
        // //                               Container(
        // //                                 alignment: Alignment.centerLeft,
        // //                                 decoration: BoxDecoration(
        // //                                     //border: Border.all(width: 1),
        // //                                     ),
        // //                                 child: Text(
        // //                                   'Telefono N°1 \n +56 9 5696 9999',
        // //                                   style: TextStyle(
        // //                                       fontSize: 15,
        // //                                       fontWeight: FontWeight.bold),
        // //                                 ),
        // //                               ),
        // //                               Container(
        // //                                 alignment: Alignment.centerRight,
        // //                                 decoration: BoxDecoration(
        // //                                     //border: Border.all(width: 1),
        // //                                     ),
        // //                                 child: Text(
        // //                                   'Telefono N°2 \n +56 9 5696 9999',
        // //                                   style: TextStyle(
        // //                                       fontSize: 15,
        // //                                       fontWeight: FontWeight.bold),
        // //                                 ),
        // //                               ),
        // //                             ],
        // //                           ),
        // //                         ],
        // //                       ),
        // //                       decoration: BoxDecoration(
        // //                         color: Color.fromARGB(255, 68, 137, 255),
        // //                         borderRadius: BorderRadius.circular(5),
        // //                         border: Border.all(
        // //                           width: 5,
        // //                           color: Color(0xB6BB3939),
        // //                         ),
        // //                       ),
        // //                     ),
        // //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SliverAppBar(
        //       pinned: false,
        //       expandedHeight: 300,
        //       backgroundColor: Colors.transparent,
        //       flexibleSpace: FlexibleSpaceBar(
        //         background: SafeArea(
        //           child: RotatedBox(
        //             quarterTurns: -1,
        //             child: Container(
        //               alignment: Alignment.center,
        //               child: ListWheelScrollView(
        //                 magnification: 2,
        //                 itemExtent: 100,
        //                 // children: Botones,
        //                 children: [],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
