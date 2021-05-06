import 'package:second_exam_flutter/src/pages/login.dart';
import 'package:second_exam_flutter/src/pages/square.dart';
import 'package:second_exam_flutter/src/pages/sort_name.dart';
import 'package:second_exam_flutter/src/pages/random.dart';
import 'package:flutter/material.dart';
import 'package:second_exam_flutter/src/pages/welcome.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/':(BuildContext context) => LoginPage(),
    'menubienvenida': (BuildContext context) => WelcomePage(),
    'square':(BuildContext context) => SquarePage(),
    'sort':(BuildContext context) => SortNamePage(),
    'random':(BuildContext context) => RandomPage(),
  };
}