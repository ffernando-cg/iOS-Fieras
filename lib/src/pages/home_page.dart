import 'package:flutter/material.dart';
import 'package:navigation_practice/src/pages/subpage.dart';
import 'package:navigation_practice/src/providers/menu_providers.dart';
import 'package:navigation_practice/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Componentes')),
      body: _lista(),
    );
  }

  Widget _lista() {
    // Future builder
    return FutureBuilder(
        future: menuProvider.loadData(),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _listaItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    int contador = 0;

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['text']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          final route = MaterialPageRoute(
              builder: (context) => SubPage(contador) // FALTA AGREGAR AQUI
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
