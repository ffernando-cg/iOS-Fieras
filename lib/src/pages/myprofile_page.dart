import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _logOut(context);
            },
          child: Text('Cerrar Sesión'),
          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
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

  _logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/');
  }
}