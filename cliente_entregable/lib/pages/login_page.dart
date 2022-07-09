import 'dart:ui';

import 'package:cliente_entregable/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String error = "";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.black87),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50),
                        buildLogo(height),
                        SizedBox(height: 30),
                        buildEmailPassword(),
                        SizedBox(height: 20),
                        buildButtonLogIn(),
                        Separad_OR(),
                        buildGoogleButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo(height) {
    return Container(
      width: height * 0.3,
      height: height * 0.3,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }

  Widget buildEmailPassword() {
    return Column(
      children: [
        // EMAIL
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: TextFormField(
            controller: emailCtrl,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              fillColor: Colors.white.withOpacity(0.9),
              filled: true,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 5),
        // PASSWORD
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: TextFormField(
            controller: passwordCtrl,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              fillColor: Colors.white.withOpacity(0.9),
              filled: true,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            obscureText: true,
          ),
        ),
        if (error != "")
          Container(
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            color: Colors.red,
            child: Text(
              error,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildButtonLogIn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Text('Iniciar sesión con Correo'),
        icon: Icon(
          MdiIcons.email,
          color: Colors.blueGrey,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightGreen.shade300,
          onPrimary: Colors.black,
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          // ignore: unused_local_variable
          UserCredential? userCredential;
          try {
            userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailCtrl.text.trim(),
              password: passwordCtrl.text.trim(),
            );

            SharedPreferences sp = await SharedPreferences.getInstance();
            sp.setString('userEmail', emailCtrl.text.trim());

            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => HomePage(),
            );
            Navigator.pushReplacement(context, route);
          } on FirebaseAuthException catch (ex) {
            // print('EXCEPTION: ${ex.code}');
            switch (ex.code) {
              case 'user-not-found':
                error = 'Usuario no existe';
                break;
              case 'wrong-password':
                error = 'Contraseña no válida';
                break;
              case 'user-disabled':
                error = 'Cuenta desactivada';
                break;
              default:
                error = 'Error desconocido';
            }
            setState(() {});
          }
        },
      ),
    );
  }

  Widget Separad_OR() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black38,
              ),
            ),
          ),
          Text('o'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black38,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildGoogleButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Text('Iniciar sesión con Google'),
        icon: Icon(
          MdiIcons.google,
          color: Colors.red,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
