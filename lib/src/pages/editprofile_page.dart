import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _fecha, _nombre, _apellido, _curp;
  var currentData;
  
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _curpController = new TextEditingController();

  final _formKeyRegister = GlobalKey<FormState>();

  int _value = 1;
  



  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    final uid = user.uid; 
    
    _firestore.collection('usuariosLeon').doc(uid).get().then((value) {
          currentData = value.data();
          setState(() {
            _curpController.text = user.email.split('@')[0].toUpperCase();
            _curp = _curpController.text;
            _nombre = currentData["nombre"];
            _apellido = currentData["apellidos"];
          });
        }
      );

      _tryUpdate(BuildContext context){
        _firestore.collection('usuariosLeon').doc(uid).update({
          "apellidos":_apellido,
          "fechnam": _fecha.toString(),
          "nombre": _nombre,
        }).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cuenta modificada correctamente'),
              ),
            );
            Navigator.pop(context);
        }
      );
  }

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar mi perfil'),
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
                      textCapitalization: TextCapitalization.characters,
                      controller: _curpController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'CURP',
                      ),
                      validator: (String val){
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
                        key: Key(_nombre.toString()),
                        initialValue: _nombre.toString(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                          labelText: 'Nombre(s)'),
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('Name is required');
                        }
                        _nombre = val.trim();
                      },
                    ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                        key: Key(_apellido.toString()),
                        initialValue: _apellido.toString(),
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
                        _apellido = val.trim();
                      },
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:_crearFecha(this.context),
                    ),
                  ])),
                    ElevatedButton(
                      onPressed: (){

                        if(_formKeyRegister.currentState.validate()){
                          _tryUpdate(context);
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
        validator: (String val){
          if(val.trim().isEmpty){
            return ('Fecha no seleccionada');
          }
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


  
}