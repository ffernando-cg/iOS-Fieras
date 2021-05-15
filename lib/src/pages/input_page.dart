import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputPage extends StatefulWidget {
  InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre ='', _email ='', _pass='', _fecha = '';

  List<String> _oficios = ['Carpintero', 'Zapatero', 'Electricista', 'Herrero', 'Vendedor'];

  String _opcionPreselect = 'Carpintero' ;

TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs presonalizados'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: <Widget>[
          _crearInput(),
           Divider(),
           _crearEmail(),
            Divider(),
            _crearPassword(),
            Divider(),
            _crearFecha(this.context),
            Divider(),
            _crearLista(),
            Divider()

            ],
      ),
    );
  }

  Widget _crearInput(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: Text('caracteres 0'),
        hintText: 'Tu nombre',
        helperText: 'solo letras-',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      onChanged: (valor){
        setState(() {
          _nombre = valor;
        });
      },
    );
  }


  Widget _repitnar(){
    return ListTile(
      title: Text('Su nombre es: $_nombre'),
    );
  }

  Widget _crearEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'email',
        labelText: 'email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _crearPassword() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
      onChanged: (value) {
        setState(() {
          _pass = value;
        });
      },
    );
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
          _fecha = picked.toIso8601String();
          _inputFieldDateController.text = DateFormat('dd/MM/yyyy').format(picked);

          //Opcion b
          // _fecha = `$picked.day / $picked.month / $picked.year`;
        });
      }
  }

    List<DropdownMenuItem<String>> getOpciones(){
      List<DropdownMenuItem<String>> lista = new List();
      _oficios.forEach((oficio) {
        lista.add(DropdownMenuItem(
          value: oficio,
          child: Text(oficio),
        ));
      });
      return lista;
    }

  Widget _crearLista() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
            value: _opcionPreselect,
            items: getOpciones(),
            onChanged: (opt){
              setState(() {
                
              });
            },
          )
          )
      ],
    );
  }
}