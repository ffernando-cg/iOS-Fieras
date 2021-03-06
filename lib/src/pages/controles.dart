import 'package:flutter/material.dart';

class ControlesPage extends StatefulWidget {
  @override
  createState() {
    return _controlesState();
  }
}

class _controlesState extends State<ControlesPage> {
  final _estilo = new TextStyle(fontSize: 30);
  final limiteT = 10;
  final limiteB = -10;
  int _positionY = 0;
  int _actualPosition = 0;

  String cadena = '';
  String warning = '';

  void instructionsCenter() => {
        setState(() {
          _positionY = 0;
          _actualPosition = 0;
          cadena = 'Inicio';
          warning = '';
        })
      };

  void instructionsTop() => {
        setState(() {
          _positionY++;

          if (_positionY >= limiteT) {
            _positionY = 10;
            warning = 'Llegaste al limite superior';
          }
        })
      };

  void instructionsBottom() => {
        setState(() {
          _positionY--;

          if (_positionY <= limiteB) {
            _positionY = 0;
            warning = 'Llegaste al limite inferior';
          }
        })
      };

  void instructionRight() => {
        setState(() {
          _actualPosition++;

          if (_actualPosition > 3) _actualPosition = 0;

          switch (_actualPosition) {
            case 0:
              {
                cadena = 'Norte';
                break;
              }
            case 1:
              {
                cadena = 'Este';
                break;
              }
            case 2:
              {
                cadena = 'Sur';
                break;
              }
            case 3:
              {
                cadena = 'Oeste';
                break;
              }
          }
        })
      };

  void instructionLeft() => {
        setState(() {
          _actualPosition--;
          if (_actualPosition < 0) _actualPosition = 3;

          switch (_actualPosition) {
            case 0:
              {
                cadena = 'Norte';
                break;
              }
            case 1:
              {
                cadena = 'Este';
                break;
              }
            case 2:
              {
                cadena = 'Sur';
                break;
              }
            case 3:
              {
                cadena = 'Oeste';
                break;
              }
          }
        })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicación chida'),
        centerTitle: true,
      ),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
            ),
            FlatButton(
                child: Icon(Icons.arrow_upward), onPressed: instructionsTop),
            Container(
              padding: const EdgeInsets.all(8),
            ),
            FlatButton(
                child: Icon(Icons.arrow_back), onPressed: instructionLeft),
            FlatButton(
                child: Icon(Icons.circle), onPressed: instructionsCenter),
            FlatButton(
                child: Icon(Icons.arrow_forward), onPressed: instructionRight),
            Container(
              padding: const EdgeInsets.all(8),
            ),
            FlatButton(
                child: Icon(Icons.arrow_downward),
                onPressed: instructionsBottom),
            Container(
              padding: const EdgeInsets.all(8),
            ),
            Text('$cadena'),
            Container(
              padding: const EdgeInsets.all(8),
            ),
            Text('$warning')
          ]),
    );
  }
}
