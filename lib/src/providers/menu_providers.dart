import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];
  List<dynamic> opcionesSpec = [];

  _MenuProvider() {
    loadData();
    loadSubMenuData();
  }

  Future<List<dynamic>> loadData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');

    Map dataMap = json.decode(resp);
    print(dataMap);
    opciones = dataMap['routes'];

    return opciones;
  }

  Future<List<dynamic>> loadSubMenuData() async {
    final resp = await rootBundle.loadString('data/menu_opts_submenu.json');

    Map dataMap = json.decode(resp);
    print(dataMap);
    opcionesSpec = dataMap['subroute'];
    return opcionesSpec;
  }
}

final menuProvider = new _MenuProvider();
