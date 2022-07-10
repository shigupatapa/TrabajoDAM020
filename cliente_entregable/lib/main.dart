import 'package:cliente_entregable/provider/google_signin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cliente_entregable/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Jardin Carrusel',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('es'), // Spanish, no country code
          ],
          theme: ThemeData(
              // This is the theme of your application.
              // primarySwatch: Colors.blue,
              ),
          home: HomePage(),
        ),
      );
}
