import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/page/direcciones_page.dart';
import 'package:qrreaderapp/src/page/home_page.dart';
import 'package:qrreaderapp/src/page/mapa_page.dart';
import 'package:qrreaderapp/src/page/mapas_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home'        : (BuildContext context) => HomePage(),
        'direcciones' : (BuildContext context) => DireccionesPage(),
        'mapas'       : (BuildContext context) => MapasPage(),
        'mapa'        : (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.green
      ),
    );
  }
}