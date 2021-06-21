import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EditPassPage extends StatefulWidget {

  @override
  _EditPassPageState createState() => _EditPassPageState();
}

class _EditPassPageState extends State<EditPassPage> {
   String _nombres, _apellidos, _curp,_sexo, _passAnterior, _passNuevo, passConfNuevo, _fecha;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  final _formKeyRegister = GlobalKey<FormState>();

  bool isCurpError=false, isPassError=false, isConfirmPassError=false;
  int _value = 1;
  
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    final uid = user.uid; 

    return Scaffold(
        appBar: AppBar(
          title: Text('Cambiar de contraseña'),
        ),
        body: Form(
          key: _formKeyRegister,
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20),
                  child: Column(
                    children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'Contraseña anterior',
                      ),
                      validator: (String val){
                          if(isPassError){
                            return('La contraseña proporcionada es incorrecta');
                          }
                          if(val.trim().isEmpty){
                            return('La contraseña es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                          /////////////////////////////////////////////////////_pass = val.trim();
                        },
                    ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'Contraseña nueva',
                      ),
                      validator: (String val){
                          if(isPassError){
                            return('La contraseña proporcionada es incorrecta');
                          }
                          if(val.trim().isEmpty){
                            return('La contraseña es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                         ///////////////////////////////////////////////// _pass = val.trim();
                        },
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'Confirmar contraseña nueva',
                      ),
                     /* onChanged: (String val){
                        setState(() {
                          _conpass = val.trim();
                        });
                      },*/
                      validator: (String val){
                          if(isConfirmPassError){
                            return('La contraseñas no coinciden');
                          }
                          if(val.trim().isEmpty){
                            return('La contraseña es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                         //////////////////////////////////////////////// _conpass = val.trim();
                        },
                    ),
                    )
                  ])),
                    ElevatedButton(
                      onPressed: (){
                        // if(_conpass != _pass){
                        //   isConfirmPassError=true;
                        // }

                        if(_formKeyRegister.currentState.validate()){
                          //-------------------------------------------------------------------_tryUpdate(_curp, _pass, context);
                        }else{
                          AlertDialog(
                            title: const Text('AlertDialog Title'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('This is a demo alert dialog.'),
                                  Text('Would you like to approve of this message?'),
                                ],
                              ),
                            ),
                          );
                        }
              },
              child: const Icon(Icons.check),
            ),
            ]))));
  }
}