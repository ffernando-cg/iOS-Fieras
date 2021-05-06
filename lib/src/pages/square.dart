import 'package:flutter/material.dart';
import 'dart:math';

class SquarePage extends StatefulWidget {
  SquarePage({Key key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {

  int _numeroA=0,_numeroB=0,_numeroC=0;
  double disc = 0.0;
  double _x1 = 0.0;
  double _x2 = 0.0;

  void ecuacion() => {
    setState(() {
      if(_numeroA == null && _numeroB == null && _numeroC == null){
        showAlertDialog(context);
      } else if(_numeroA == '' || _numeroB == '' || _numeroC == ''){
        showAlertDialog(context);
      } else if (_numeroA < 0){
        showAlertDialog(context);
      }
      else {
        disc = (_numeroB*_numeroB - 4*_numeroA*_numeroC).toDouble();
        _x1 = (-_numeroB + sqrt(disc))/(2*_numeroA).toDouble();
        _x2 = (-_numeroB - sqrt(disc))/(2*_numeroA).toDouble();
      }
    })
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
       appBar: AppBar(
           title: Text('Ecuación Cuadrática')
       ),
       body: Container(
        margin: EdgeInsets.all(50),
        child: ListView(
          children: <Widget>[
            Image(
              image: AssetImage('images/EcuacionCuadratica.png')
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el valor de A'
              ),
              onChanged: (e)=>{
                if(!isNumericUsingRegularExpression(e)){
                  print('El valor del campo A no es un numero')
                }
                else{
                  _numeroA = int.parse(e)
                }
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el valor de B'
              ),
              onChanged: (e)=>{
                if(!isNumericUsingRegularExpression(e)){
                  print('El valor del campo B no es un numero')
                }
                else{
                  _numeroB = int.parse(e)
                }
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el valor de C'
              ),
              onChanged: (e)=>{
                if(!isNumericUsingRegularExpression(e)){
                  print('El valor del campo C no es un numero')
                }
                else{
                  _numeroC = int.parse(e)
                }
              },
            ),
            Padding(padding: EdgeInsets.only(top:60.0)),
            TextField(
              enabled: false,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$_x1'
              ),
            ),
            TextField(
              enabled: false,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$_x2'
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:45),
              child:
                ElevatedButton(
                  onPressed: (){
                        ecuacion();
                    },
                  child: Text('Calcular'),
                  style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
                )
              ),
          ]
        )
      )
    );
  }
}

showAlertDialog(BuildContext context) {  
  // Create button  
  Widget okButton = FlatButton(  
    child: Text("OK"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: Text("Simple Alert"),  
    content: Text("Ingrese un valor válido"),  
    actions: [  
      okButton,  
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}

Color getColorForElevatedButton(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.green[500];
  }

  bool isNumericUsingRegularExpression(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}