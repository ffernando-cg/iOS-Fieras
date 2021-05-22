import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget{
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String _nomcom, _apellidos, _sexo, _curp, _pass, _conpass, _fecha;
  int _value = 1;

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var padding;
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrarse'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Preguntas?',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Todos los datos pedidos son para su seguirdad y evitar acciones fraudulentas')));
              },
          ),
          ],
        ),
        body: Container(
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
                          labelText: 'Nombre Completo'),
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

                    // DROPDOWN PARA EL SEXO PREGUNTAR AL EQUIPO AL RESPECTO
                   /* DropdownButton(
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text("Mujer"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Hombre"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Otro"),
                            value: 3,
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),*/
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:TextFormField(
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0),),
                          ),
                        labelText: 'CURP',
                      ),
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('CURP is required');
                        }
                        _curp = val.trim();
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
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('Password is required');
                        }
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
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return ('Password is required');
                        }
                        _conpass = val.trim();
                      },
                    ),
                    )
                  ])),
                    FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Icon(Icons.check),
              backgroundColor: Colors.green,
            ),
            ])));
  }


 Widget _crearFecha(BuildContext context) {

    return TextFormField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha',
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
          _fecha = '$picked.day / $picked.month / $picked.year';
        });
      }
  }



}

validate(String curp, String password, BuildContext context) {
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


