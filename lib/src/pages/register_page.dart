import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String _nomcom, _apellidos, _curp, _pass, _conpass, _fecha, _sexo;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKeyRegister = GlobalKey<FormState>();

  bool isCurpError=false, isPassError=false, isConfirmPassError=false;
  int _value = 1;
  
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrarse'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Dudas?',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Todos los datos pedidos son para su seguirdad y evitar acciones fraudulentas')));
              },
          ),
          ],
        ),
        body: Form(
          key: _formKeyRegister,
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: ListView(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: <Widget>[
                     Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                          labelText: 'Nombre(s)'),
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('Name is required');
                        }
                        _nomcom = val.trim();
                      },
                    ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'Apellido(s)',
                      ),
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('Apellido is required');
                        }
                        _apellidos = val.trim();
                      },
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:_crearFecha(this.context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'CURP',
                      ),
                      validator: (String val){
                        if(isCurpError){
                          return('El curp proporcionado no existe');
                        }
                        if(val.trim().isEmpty){
                          return('CURP is required');
                        }
                        if( val.trim().length <=17 )
                          return ('El CURP proporcionado esta incompleto');
                        if(val.trim().length >= 19) 
                          return('El CURP es demasiado largo');
                        _curp = '${val.trim()}@fieras.com';
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
                        labelText: 'Contraseña',
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


                          _pass = val.trim();
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
                        labelText: 'Confirmar contraseña',
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


                          _conpass = val.trim();
                        },
                    ),
                    )
                  ])),
                    ElevatedButton(
                      onPressed: (){
                        if(_conpass != _pass){
                          isConfirmPassError=true;
                        }

                        if(_formKeyRegister.currentState.validate()){
                          _tryRegister(_curp, _pass, context);
                        }else{
                          AlertDialog(
                            title: const Text('Error!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Oh no!'),
                                  Text('A ocurrido un error, porfavor intentalo de nuevo'),
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

 Widget _crearFecha(BuildContext context) {

    return TextFormField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
          )
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectFecha(context);
        },
    );
  }

  void _selectFecha(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1900), 
      lastDate: new DateTime(2022)
      );

      if(picked != null){
        setState(() {
          _fecha = DateFormat('dd/MM/yyyy').format(picked).toString();
          _inputFieldDateController.text = _fecha.toString();
        });
      }
  }

  Widget _tryRegister(String curp, String pass, BuildContext context) {
    auth.createUserWithEmailAndPassword(email: curp, password: pass).then(
          (cred) { 
            
            _firestore.collection('usuariosLeon').doc(cred.user.uid).set({
                'nombre': _nomcom,
                'apellidos': _apellidos,
                'fechnam': _fecha,
                'esdeudor':'no',
                'fechavencimiento': '20/06/2021'
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cuenta creada correctamente'),
              ),
            );
            Navigator.pop(context);
          }
        ).catchError((e){
          switch (e.message) {
                case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                  isCurpError=true;
                  _formKeyRegister.currentState.validate();
                  break;
                case 'The password is invalid or the user does not have a password.':
                  isPassError=true;
                  _formKeyRegister.currentState.validate();
                  break;
                default:
                  print('Case ${e.message} is not yet implemented');
              }
        }); 
        return null;
  }
}