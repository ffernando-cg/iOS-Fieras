import 'package:flutter/material.dart';

class ControlesPage extends StatefulWidget {
  @override
  createState() {
    return _controlesState();
  }
}

class _controlesState extends State<ControlesPage> {
  // const color = this.props.dataItem;
  final _estilo = new TextStyle(fontSize: 30);

  int _positionX = 1;
  int _positionY = 1;
  int _actualPosition = 0;

  List<Color> colores = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  String cadena = '';
  String warning = '';

  void instructionsCenter() => {
        setState(() {
          _positionY = 1;
          _positionX = 1;
          _actualPosition = 1;
          cadena = 'Inicio';
          warning = 'Regresaste a la posicion inicial';
          showActualPosition();
        })
      };

  void instructionsRight() => {
        setState(() {
          _positionY++;
          if (_positionY == 3) {
            instructionsCenter();
          }
          showActualPosition();
        })
      };

  void instructionsLeft() => {
        setState(() {
          _positionY--;
          if (_positionY == -1) {
            instructionsCenter();
          }
          showActualPosition();
        })
      };

  void instructionsBottom() => {
        setState(() {
          _positionX++;
          if (_positionX == 3) {
            instructionsCenter();
          }
          showActualPosition();
        })
      };

  void instructionsTop() => {
        setState(() {
          _positionX--;
          if (_positionX == -1) {
            instructionsCenter();
          }
          showActualPosition();
        })
      };

  void showActualPosition() => {
        setState(() {
          var dataList = List.generate(3, (i) => [0, 0, 0], growable: false);
          dataList[_positionX][_positionY] = 1;
          colores[0] = Colors.white;
          colores[1] = Colors.white;
          colores[2] = Colors.white;
          colores[3] = Colors.white;
          colores[4] = Colors.white;
          colores[5] = Colors.white;
          colores[6] = Colors.white;
          colores[7] = Colors.white;
          colores[8] = Colors.white;
          if (dataList[0][0] == 1) {
            cadena = 'Noroeste';
            colores[0] = Colors.blueAccent;
          } else if (dataList[0][1] == 1) {
            cadena = 'Norte';
            colores[1] = Colors.blueAccent;
          } else if (dataList[0][2] == 1) {
            cadena = 'Noreste';
            colores[2] = Colors.blueAccent;
          } else if (dataList[1][0] == 1) {
            cadena = 'Oeste';
            colores[3] = Colors.blueAccent;
          } else if (dataList[1][1] == 1) {
            cadena = 'Centro';
            colores[4] = Colors.blueAccent;
          } else if (dataList[1][2] == 1) {
            cadena = 'Este';
            colores[5] = Colors.blueAccent;
          } else if (dataList[2][0] == 1) {
            cadena = 'Suroeste';
            colores[6] = Colors.blueAccent;
          } else if (dataList[2][1] == 1) {
            cadena = 'Sur';
            colores[7] = Colors.blueAccent;
          } else if (dataList[2][2] == 1) {
            cadena = 'Sureste';
            colores[8] = Colors.blueAccent;
          } else {
            warning =
                'Posicion salida del recuadro, volviendo a posicion inicial';
            dataList[1][1] = 1;
            colores[3] = Colors.blueAccent;
          }
        })
      };

  @override
  Widget build(BuildContext context) {
    showActualPosition();
    return Scaffold(
      appBar: AppBar(
        title: Text('ExamenPrimerParcial_Fieras'),
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
              decoration: BoxDecoration(
                color: colores[0],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[1],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[2],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[3],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[4],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[5],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[6],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[7],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colores[8],
                border: Border.all(color: Colors.blueAccent),
              ),
            ),
            Text('$cadena'),
            FlatButton(
                child: Icon(Icons.arrow_upward), onPressed: instructionsTop),
            Text('$warning'),
            FlatButton(
                child: Icon(Icons.arrow_back), onPressed: instructionsLeft),
            FlatButton(
                child: Icon(Icons.circle), onPressed: instructionsCenter),
            FlatButton(
                child: Icon(Icons.arrow_forward), onPressed: instructionsRight),
            Container(
              padding: const EdgeInsets.all(8),
            ),
            FlatButton(
                child: Icon(Icons.arrow_downward),
                onPressed: instructionsBottom),
            Container(
              padding: const EdgeInsets.all(8),
            ),
          ]),
    );
  }
}
