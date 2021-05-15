import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Page')
      ),
      body: ListView(
        children: <Widget>[
          _cardt1(),
          SizedBox(
            height: 30,
          ),
          _cardt2(),
          SizedBox(
            height: 30,
          ),
          _cardt2(),
          SizedBox(
            height: 30,
          ),
          _cardt2(),
          SizedBox(
            height: 30,
          ),
          _cardt2(),
          SizedBox(
            height: 30,
          ),

          _cardt2(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
      );
  }

  Widget _cardt1() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.assistant_photo, color:Colors.blue),
            title: Text('Francisco Fernando Cruz Galvez'),
            subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){},
              ),
              FlatButton(
                child: Text('OKNT'),
                onPressed: (){},
              )
            ],
          )
        ]
      ),
    );
  }

    Widget _cardt2(){
      final card = Container(
        child: Column(
          children: <Widget>[
            FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'), 
            image: NetworkImage('https://cdn.pixabay.com/photo/2021/04/11/14/39/pick-up-6170000_960_720.png'),
            fadeInDuration: Duration(milliseconds: 500),
            height: 300.0,
            fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text('Descripcion de la imagen en el contenedor')
            )
          ]
        ),
        );
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: card,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(
                    2.0, 7
                  )
                )
              ],
              color: Colors.red
            ),
        );
    }
}