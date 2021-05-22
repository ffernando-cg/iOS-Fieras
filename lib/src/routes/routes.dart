
import 'package:app_leon_project/src/pages/login_page.dart';
import 'package:app_leon_project/src/pages/main_screen_page.dart';
import 'package:app_leon_project/src/pages/register_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/':(BuildContext context) => LoginPage(),
    'mapscreen': (BuildContext context) => MainScreenPage(),
    'register': (BuildContext context) => RegisterPage()
  };
}