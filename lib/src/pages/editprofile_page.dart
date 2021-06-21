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
  String _fecha;
  var currentData;
  
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _nombresController = new TextEditingController();
  TextEditingController _apellidosController = new TextEditingController();
  TextEditingController _curpController = new TextEditingController();

  final _formKeyRegister = GlobalKey<FormState>();

  bool isCurpError=false, isPassError=false, isConfirmPassError=false;
  int _value = 1;
  



  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    final uid = user.uid; 
    
    _firestore.collection('usuariosLeon').doc(uid).get().then((value) {
          currentData = value.data();
          setState(() {
            _curpController.text = user.email.split('@')[0].toUpperCase();
            _nombresController.text = currentData["nombre"];
            _apellidosController.text = currentData["apellidos"];
            _inputFieldDateController.text = currentData["fechnam"];
          });
        }
      );

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
                      readOnly: true,
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
                        ////////////////////////////////////////////////_curp = '${val.trim()}@fieras.com';
                      },
                    ),
                    ),
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
                        //////////////////////////////////////////////////_nombres = val.trim();
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
                        /////////////////////////////////////////////_apellidos = val.trim();
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
      firstDate: new DateTime(2017), 
      lastDate: new DateTime(2030)
      );

      if(picked != null){
        setState(() {
          _fecha = DateFormat('dd/MM/yyyy').format(picked).toString();
          _inputFieldDateController.text = _fecha.toString();
        });
      }
  }
}