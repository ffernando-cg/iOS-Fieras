import 'package:components_practice/src/pages/alert_page.dart';
import 'package:components_practice/src/providers/menu_providers.dart';
import 'package:components_practice/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes')
      ),
      body: _lista(),
    );
  }


    Widget _lista(){
      // Future builder
      return FutureBuilder(
        future: menuProvider.cargarData(),
        initialData: [],
        builder: (context, AsyncSnapshot <List<dynamic>> snapshot){
          return ListView(
            children: _listaItems(snapshot.data, context),
          );
        }
      );
    }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['text']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),

        onTap: (){
          /* final route = MaterialPageRoute(
           * builder: (context) => AlertPage() 
           * );
           */

          Navigator.pushNamed(context,opt['ruta']);
        },
      );

      opciones..add(widgetTemp)
              ..add(Divider());
    });
    return opciones;
  }
  }
