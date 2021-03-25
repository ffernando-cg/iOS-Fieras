import 'package:flutter/material.dart';
import 'package:navigation_practice/src/pages/alert_page.dart';
import 'package:navigation_practice/src/providers/menu_providers.dart';
import 'package:navigation_practice/src/utils/icono_string_util.dart';

class SubPage extends StatelessWidget {
  SubPage(this.contador);
  final int contador;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Componentes')),
      body: _listaSubMenus(),
    );
  }

  Widget _listaSubMenus() {
    // Future builder
    return FutureBuilder(
        future: menuProvider.loadSubMenuData(),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _listaItemsSubMenu(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItemsSubMenu(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    int contador = 0;

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['text']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          final route = MaterialPageRoute(
              builder: (context) =>
                  AlertPage(opt['mini-route']) // FALTA AGREGAR AQUI
              );
          Navigator.push(context, route);
        },
      );
      opciones..add(widgetTemp)..add(Divider());
      contador++;
    });
    return opciones;
  }
}
