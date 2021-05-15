import 'package:components_practice/src/pages/alert_page.dart';
import 'package:components_practice/src/pages/animated_container.dart';
import 'package:components_practice/src/pages/avatar_page.dart';
import 'package:components_practice/src/pages/card_page.dart';
import 'package:components_practice/src/pages/home_page.dart';
import 'package:components_practice/src/pages/input_page.dart';
import 'package:components_practice/src/pages/listView_page.dart';
import 'package:components_practice/src/pages/slider_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/':(BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedcontainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputPage(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListPage()
  };
}