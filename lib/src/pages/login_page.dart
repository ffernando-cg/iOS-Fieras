import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  String _curp, _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //  title: Text('LoginPage'),
      // ),
      body: Container(
        margin: const EdgeInsets.only(top:80.0,left: 20.0, right: 20.0),
        child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage('images/LeonLogo.png')
                ),
                Container(
                  margin: EdgeInsets.only(top:30.0),
                  child:Column(children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your CURP'
                      ),
                      validator: (String val){
                        if(val.trim().isEmpty){
                          return('CURP is required');
                        }
                        _curp = val.trim();
                      },
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your password',
                        ),
                        validator: (String val){
                          if(val.trim().isEmpty){
                            return('Password is required');
                          }
                          _pass = val.trim();
                        },
                      ),
                      Padding(
                      padding: EdgeInsets.only(top:25),
                      child:
                        ElevatedButton(
                          onPressed: () => {
                            //validate(_curp,_pass, context)
                            Navigator.pushNamed(context, 'mapscreen')
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
                          
                        },
                        child: const Text('Register'),
                      )
                      
                  ]
                  )
                )
              ]
            )
      )
    );
  }
}


  validate(String curp, String password, BuildContext context){
    //TODO Send to API the props to verify with database
    //
  
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