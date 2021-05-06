import 'dart:convert';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool up =false;
    final  Map<String, Object>datosRecibidos = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
        
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
            title: Text('Bienvenido! ${datosRecibidos["name"]}')
        ),
        body: ListView(
          padding: EdgeInsets.only(top:50),
        children: [
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Center(
                child: Text(
                  'Bienvenido! ${datosRecibidos["name"]}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Divider(),
              Center(
                child: Text(
                  'Con una edad de: ${datosRecibidos["edad"]}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ),
              Divider(),
              Center(
                child: Text(
                  'En el estado de: ${datosRecibidos["estado"]}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ),
              Divider(),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                children:[ 
                  MaterialButton(
                    onPressed: () { Navigator.pushNamed(context, 'square');},
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    onPressed: () { Navigator.pushNamed(context, 'sort'); },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text(
                      'B',
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    onPressed: () { Navigator.pushNamed(context, 'random'); },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      'C',
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                ]
              ),
              Padding(padding: EdgeInsets.only(top:340.0)),
              Icon(Icons.arrow_downward, color: Colors.white),
              Text('Scroll down for a surprise', style: TextStyle(color: Colors.white24)),
              Padding(padding: EdgeInsets.only(top:100.0, bottom: 50.0)),
              Text('¿¿¿¿¿SABIAS QUE?????', style: TextStyle(color: Colors.white, fontSize: 35)),
              Image(image: AssetImage('images/Sabiasque1.png')),
          ]
        )
        )
        ]
    )
    );
  }
}



  Color getColorForElevatedButton(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blueAccent;
      }
      return Colors.red[700];
    }
