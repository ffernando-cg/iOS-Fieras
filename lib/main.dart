import 'dart:async';
import 'package:app_leon_project/src/pages/login_page.dart';
import 'package:app_leon_project/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getAplicationRoutes(),
      onGenerateRoute: (RouteSettings settings){
        print('Ruta : ${settings.name}');
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginPage()
          );
      },
    );
  }
}