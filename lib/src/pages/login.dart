import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    String _name, _age, _state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Container(
        margin: const EdgeInsets.only(top:80.0,left: 20.0, right: 20.0),
        child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:30.0),
                  child:Column(children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Introduce tu nombre',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (String val){
                        if(val.trim().isEmpty){
                          return('El nombre es requerido');
                        }
                          _name = val.trim();
                      },
                      ),
                      Padding(padding: EdgeInsets.only(top:40)),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Introduce tu edad',
                          labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (String val){
                        if(val.trim().isEmpty){
                          return('La edad es requerida');
                        }
                          _age = val.trim();
                      },
                      ),
                      Padding(padding: EdgeInsets.only(top:40)),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Introduce tu estado',
                          labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (String val){
                        if(val.trim().isEmpty){
                          return('El estado es requerido');
                        }
                          _state = val.trim();
                      },
                      ),                       
                      Padding(
                      padding: EdgeInsets.only(top:45),
                      child:
                        ElevatedButton(
                          onPressed: (){
                            Map<String, dynamic> userParams = {
                              "name": '$_name',
                              "edad": '$_age',
                              "estado": '$_state'
                            };
                            Navigator.pushNamed(context, 'menubienvenida', arguments: userParams);
                            },
                          child: Text('Log-in'),
                          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
                        )
                      ),
                      
                  ]
                  )
                )
              ]
            )
      )
    );
  }
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
