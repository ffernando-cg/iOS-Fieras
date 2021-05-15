import 'package:components_practice/src/pages/alert_page.dart';
import 'package:components_practice/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES')
      ],
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      //home:HomePage(),


      // PARA INICIALIZAR LA RUTA EN LA QUE COMIENZA
      initialRoute: '/',

      //Declara las rutas existentes y como estas se redirigen una a otra
      routes: getAplicationRoutes(),

      //Al generar una ruta imprime el nombre de esta
      onGenerateRoute: (RouteSettings settings){
        print('Ruta : ${settings.name}');
        //Si en caso la ruta no existe puedo redireccionar a una ruta estatica
        return MaterialPageRoute(
          builder: (BuildContext context) => AlertPage()
          );
      },
    );
  }
}