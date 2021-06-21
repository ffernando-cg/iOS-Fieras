import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  String _curp, _pass;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isCurpError=false, isPassError=false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /*if( auth.currentUser != null ){
     Navigator.pushNamed(context, 'mapscreen');
    }*/
 
    var _controllerCURP = TextEditingController();
    
    return Scaffold(  
      body: Container(
        margin: const EdgeInsets.only(top:80.0,left: 20.0, right: 20.0),
        child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage('images/LeonLogo.png')
                ),
                Container(
                  margin: EdgeInsets.only(top:30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      controller: _controllerCURP,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your CURP',
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        suffixIcon: IconButton(
                          onPressed: () => _controllerCURP.clear(),
                          icon: Icon(Icons.clear),
                        )
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
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your password',
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
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
                      Padding(
                      padding: EdgeInsets.only(top:25),
                      child:
                        ElevatedButton(
                          onPressed: () => {
                            
                            if(_formKey.currentState.validate()){
                              _tryLogin(_curp, _pass, context)
                            }else{
                              SnackBar(
                                content: Text('Oh no! Algo malo acaba de ocurrir, porfavor intente de nuevo. Puede que su curp o contraseña esté erroneos, verifiquelo'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              )
                            }
                            },
                          child: Text('Log-in'),
                          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
                        )
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith(getColorForTextBttn),
                        ),
                        onPressed: () {
                          
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text('Register'),
                      )
                      
                  ]
                  )
                )
                )]
          )
      )
      
    );
  }

  _tryLogin(String curp, String pass, BuildContext context){
        auth.signInWithEmailAndPassword(email: curp, password: pass).then(
          (value) => Navigator.pushNamed(context, 'mapscreen')
        ).catchError((e){
          switch (e.message) {
                case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                  isCurpError=true;
                  _formKey.currentState.validate();
                  break;
                case 'The password is invalid or the user does not have a password.':
                  isPassError=true;
                  _formKey.currentState.validate();
                  break;
                default:
                  print('Case ${e.message} is not yet implemented');
              }
        }); 
  }
}

  Color getColorForTextBttn(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orangeAccent;
      }
      return Colors.blue[100];
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