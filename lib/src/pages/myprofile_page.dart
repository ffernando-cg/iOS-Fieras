import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyProfilePage extends StatefulWidget {

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
 FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var currentData;
  String _nombre, _edad, _isDeudor;
  @override
  Widget build(BuildContext context) {
      final User user = _auth.currentUser;
      final uid = user.uid; 

      void _showAlertDialog() {
          showDialog(
            context: context,
            builder: (buildcontext) {
              return AlertDialog(
                title: Text("¿De verdad desea borrar su cuenta?"),
                content: Text("Esta acciones es irreversible e irreparable, Si acepta borrar su cuenta se borrarán todos los datos que esten anhidados a esta"),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("CERRAR", style: TextStyle(color: Colors.blue),),
                    onPressed: (){ Navigator.of(context).pop(); },
                  ),
                  RaisedButton(
                    child: Text("BORRAR", style: TextStyle(color: Colors.red),),
                    onPressed: (){ 
                      _firestore.collection('usuariosLeon').doc(uid).delete().then((value){
                        _auth.signOut();
                        user.delete();
                        Navigator.of(context).popUntil((route)=> route.isFirst);
                      }
                      );
                    },
                  ),
                ],
              );
            }
          );
        }
         
      _firestore.collection('usuariosLeon').doc(uid).get().then((value) {
        currentData = value.data();
        setState(() {
          _nombre = currentData["nombre"] + " " +currentData["apellidos"];
          _edad = calculateAge(currentData["fechnam"]);

          _isDeudor = currentData["esdeudor"];
        });
      }
      );

    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.grey[300],
            
          ),
          child: Center(
            child: Column(
            children: <Widget>[
              Text(
                'Nombre:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[400],
                  fontSize: 18
                ),
              ),
              Text(
                  '$_nombre'
              ),
              Text(
                'Edad:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[400],
                  fontSize: 18
                ),
              ),
              Text(
                  '$_edad'
              ),
              Text(
                '¿Tiene alguna deuda pendiente?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[400],
                  fontSize: 18
                ),
              ),
              Text(
                  '$_isDeudor'
              ),
              Text(
                'Tipo de Pagobus:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[400],
                  fontSize: 18
                ),
              ),
              Text(
                  'Estandar'
              ),
            ]
          ),
          )
          
      ),
      Padding(padding: EdgeInsets.symmetric(vertical:70)),
      ElevatedButton(
          onPressed: () {
              Navigator.pushNamed(context, 'edit');
            },
          child: Text('Editar Perfil'),
          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
        ),
        ElevatedButton(
          onPressed: () {
              Navigator.pushNamed(context, 'newpass');
            },
          child: Text('Cambiar contraseña'),
          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
        ),
        ElevatedButton(
          onPressed: () {
            _logOut(context);
            },
          child: Text('Cerrar Sesión'),
          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 35),
          child: ElevatedButton(
            onPressed: () {
              _showAlertDialog();
            },
            child: Text('Eliminar Cuenta'),
            style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButtonDelete) )
          ),
          )
        
      ] 
    );
  }

    Color getColorForElevatedButton(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.orange[300];
    }

    Color getColorForElevatedButtonDelete(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.pink;
      }
      return Colors.red[600];
    }

  _logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route)=> route.isFirst);
  }


  calculateAge(String birthDate) {
  var formatter = DateFormat('dd/MM/yyyy');
  var birthDateCasted = formatter.parse('$birthDate');
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDateCasted.year;
  int month1 = currentDate.month;
  int month2 = birthDateCasted.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDateCasted.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age.toString();
}
}