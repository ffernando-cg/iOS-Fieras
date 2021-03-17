import 'package:flutter/material.dart';

class HomePageAlternativo extends StatelessWidget {
  //final opciones = ['Uno','Dos','Tres','Cuatro','Cinco'];
  final opciones = [
    {
      "color": 0xFFB74093,
      "title": "Uno",
      "description": "Description 1",
      "iconL": Icons.account_box,
      "iconT": Icons.check
    },
    {
      "color": 0xFF3C7460,
      "title": "Dos",
      "description": "Description 2",
      "iconL": Icons.account_circle,
      "iconT": Icons.delete
    }, //account_circle
    {
      "color": 0xFF2346A6,
      "title": "Tres",
      "description": "Description 3",
      "iconL": Icons.account_tree,
      "iconT": Icons.delete
    }, //account_tree
    {
      "color": 0xFF003152,
      "title": "Cuatro",
      "description": "Description 4",
      "iconL": Icons.add_circle,
      "iconT": Icons.check
    },
    {
      "color": 0xFF695A3D,
      "title": "Cuatro",
      "description": "Description 4",
      "iconL": Icons.add_circle,
      "iconT": Icons.check
    }, //add_circle
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('listTitle'),
      ),
      body: ListView(
        children: _crearItemsCorto(),
      ),
    );
  }

  /*List <Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();
    for (var opt in opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
      );
      //lista.add(tempWidget);
      //lista.add(Divider());
      lista..add(tempWidget)..add(Divider());
    }
  }*/

  List<Widget> _crearItemsCorto() {
    return opciones.map((item) {
      return Column(children: [
        ListTile(
          tileColor: Color(item['color']),
          title: Text((item['title'])),
          subtitle: Text(item['description']),
          leading: Icon(item['iconL']),
          trailing: Icon(item['iconT']),
          onTap: () {},
        ),
        Divider(),
      ]);
    }).toList();
  }
}
