import 'package:flutter/material.dart';
import 'package:second_exam_flutter/src/pages/login.dart';
import 'package:second_exam_flutter/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Segund Parcial',
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