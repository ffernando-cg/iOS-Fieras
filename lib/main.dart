
import 'package:app_leon_project/src/pages/login_page.dart';
import 'package:app_leon_project/src/routes/routes.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());
 
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