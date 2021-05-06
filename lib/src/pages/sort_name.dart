import 'package:flutter/material.dart';

class SortNamePage extends StatefulWidget {

  @override
  _SortNamePageState createState() => _SortNamePageState();
}

class _SortNamePageState extends State<SortNamePage> {
  List<String> listaChars = List<String>(); 
  String _name;
  var listaOrdenada='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
       appBar: AppBar(
         backgroundColor: Colors.red[400],
           title: Text('Ordenar letras de un nombre')
       ),
       body: Container(
         margin: EdgeInsets.all(50),
         child: 
          ListView(
            children: <Widget>[
              
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Introduce tu nombre'
                ),
                onChanged: (val){
                  if(val==''){
                    return;
                  }
                  listaChars= [];
                  val.split('').forEach((char) {
                    listaChars.add(char);
                   });
                },
                ),
              TextField(
                enabled: false,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '$listaOrdenada'
                ),
              ),
              Padding(
                      padding: EdgeInsets.only(top:45),
                      child:
                        ElevatedButton(
                          onPressed: (){
                            listaOrdenada='';
                              listaChars.sort();
                              setState(() {
                                listaChars.forEach((element) {
                                  listaOrdenada += element;
                                });
                              });
                            },
                          child: Text('Ordenar'),
                          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith(getColorForElevatedButton) )
                        )
                      ),
            ],
          )
       ),
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
        return Colors.green;
      }
      return Colors.green[500];
    }