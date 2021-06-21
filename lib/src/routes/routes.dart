
import 'package:app_leon_project/src/pages/editpass_page.dart';
import 'package:app_leon_project/src/pages/editprofile_page.dart';
import 'package:app_leon_project/src/pages/login_page.dart';
import 'package:app_leon_project/src/pages/main_screen_page.dart';
import 'package:app_leon_project/src/pages/register_page.dart';
import 'package:app_leon_project/src/pages/searching_routes_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/':(BuildContext context) => LoginPage(),
    'mapscreen': (BuildContext context) => MainScreenPage(),
    'register': (BuildContext context) => RegisterPage(),
    'edit' : (BuildContext context) => EditProfilePage(),
    'search': (BuildContext context) => SearchingRoutesPage(),
    'newpass': (BuildContext context) => EditPassPage()
  };
}