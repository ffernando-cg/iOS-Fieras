import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EditPassPage extends StatefulWidget {
  @override
  _EditPassPageState createState() => _EditPassPageState();
}

class _EditPassPageState extends State<EditPassPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _oldpass, _newpass, _confpass;
  String _email;

  final _formKey = GlobalKey<FormState>();
  bool isCurpError=false, isPassError=false, isConfirmPassError=false;

  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    final uid = user.uid; 

    _email = user.email;

     _tryUpdate(BuildContext context){
        user.updatePassword(_newpass).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
              content: Text('Contraseña modificada correctamente'),
            ),
          );
          Navigator.of(context).popUntil((route)=> route.isFirst);
        });
    }

    user.email;

    return Scaffold(
        appBar: AppBar(
          title: Text('Cambiar de contraseña'),
        ),
        body: Form(
          key: _formKey,
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
                            return('La contraseña antigua es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                         _oldpass = val.trim();
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
                          if(val.trim().isEmpty){
                            return('La contraseña es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                         _newpass = val.trim();
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
                      validator: (String val){
                          if(isConfirmPassError){
                            return('La contraseñas nuevas no coinciden');
                          }
                          if(val.trim().isEmpty){
                            return('La contraseña es requerida');
                          }
                          if(val.trim().length <= 5 )
                          return('La contraseña es muy corta');


                         _confpass = val.trim();
                        },
                    ),
                    )
                  ])),
                    ElevatedButton(
                      onPressed: (){
                        if(_confpass != _newpass){
                          isConfirmPassError=true;
                        }

                      if(_formKey.currentState.validate()){

                        var credential = EmailAuthProvider.credential(
                            email: _email,
                            password: _oldpass
                        );

                        user.reauthenticateWithCredential(credential).then((value) => _tryUpdate(context))
                        .catchError((e){
                              switch (e.message) {
                                    case 'The password is invalid or the user does not have a password.':
                                      isPassError=true;
                                      _formKey.currentState.validate();
                                      break;
                                    default:
                                      print('Case ${e.message} is not yet implemented');
                                  }
                            }); 
                      }else{
                        AlertDialog(
                          title: const Text('Hay campos incorrectos'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Porfavor verifique los campos'),
                                Text('Talvez haya algun error en ellos'),
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