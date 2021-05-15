import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 0.0;
  double _valorSliderHeight = 0.0;
  bool _bloquearCheck = false;

  bool _bloquearSwitch = false;
  bool _bloquearSwitchHeight = false;
  bool _bloquearSwitchWidth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
        padding: EdgeInsets.only(top:50.0),
        child: Column(
          children: <Widget>[
            _crearSwitchWidth(),
            _crearSliderWidth(),
            Divider(),
            _crearSwitchHeight(),
            _crearSliderHeight(),
            Divider(),
            _crearImagen(),
            
            
          ],
        ),
      )],
    )
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de imagen',
      divisions: 20,
      value: _valorSlider,
      min: 0.0,
      max: 500.0,
      onChanged: (!_bloquearCheck) ? null : (valor){
        setState(() {
          _valorSlider = valor;
        });
      },
    );
  }

  Widget _crearSliderWidth() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de imagen',
      divisions: 20,
      value: _valorSlider,
      min: 0.0,
      max: 500.0,
      onChanged: (!_bloquearSwitchWidth) ? null : (valor){
        setState(() {
          _valorSlider = valor;
        });
      },
    );
  }

  Widget _crearSliderHeight() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de imagen',
      divisions: 20,
      value: _valorSliderHeight,
      min: 0.0,
      max: 500.0,
      onChanged: (!_bloquearSwitchHeight) ? null : (valor){
        setState(() {
          _valorSliderHeight = valor;
        });
      },
    );
  }

  Widget _crearCheck() {
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (valor){
    //     setState(() {
    //       _bloquearCheck = valor;
    //     });
    //   },
    // );

    return CheckboxListTile(
      title: Text('Habilitar Slider'),
      value: _bloquearCheck,
      onChanged: (valor){
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );

  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage('https://wallpapercave.com/wp/wp6910341.jpg'),
      width: _valorSlider,
      height: _valorSliderHeight,
      fit: BoxFit.fill,
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Habilitar Switch'),
      value: _bloquearSwitch,
      onChanged: (valor){
        setState(() {
          _bloquearSwitch = valor;
        });
      },
    );
  }

  Widget _crearSwitchWidth() {
    return SwitchListTile(
      title: Text('Habilitar Switch para el ancho'),
      value: _bloquearSwitchWidth,
      onChanged: (valor){
        setState(() {
          _bloquearSwitchWidth = valor;
        });
      },
    );
  }

  Widget _crearSwitchHeight() {
    return SwitchListTile(
      title: Text('Habilitar Switch para el alto'),
      value: _bloquearSwitchHeight,
      onChanged: (valor){
        setState(() {
          _bloquearSwitchHeight = valor;
        });
      },
    );
  }
}