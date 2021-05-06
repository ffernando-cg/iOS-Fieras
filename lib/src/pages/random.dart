import 'package:flutter/material.dart';
import 'dart:math';

class RandomPage extends StatefulWidget {

  @override
  _RandomPageState createState() => _RandomPageState();
}
class _RandomPageState extends State<RandomPage> {
  final _random = new Random();
  int _min, _max;
  var _randomNumber='';
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text ('Generar un número random')
        ),
        body: Container(
        margin: EdgeInsets.all(50),
        child: ListView(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Numero menor',
              ),
              
              onChanged: (e)=>{
                _min = int.parse(e)
              },
            ),
            Padding(padding: EdgeInsets.only(top:20.0)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número mayor'
              ),
              onChanged: (e)=>{
                _max = int.parse(e)
              },
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _randomNumber = (_min + _random.nextInt(_max - _min)).toString();
                  });
                },
                child: Text('Generar Aleatorio'),
                style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
              ),
              Padding(padding: EdgeInsets.only(top:70)),
              TextField(
                enabled: false,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '$_randomNumber'
                ),
              ),
          ]
        )
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
      return Colors.blue[700];
    }
