import 'package:flutter/material.dart';
import 'dart:async';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // Lista para agregar elementos (imagenes) a nuestro listview
  List<int> _ListaNumeros = new List();
  ScrollController _scrollController = new ScrollController();

  List<int> _ListaNumeros30 = [1002,1020,104,1058,1025,1050,139,1070,1042,104];
  int countPerIteration =0;
  int determineWhichPhoto=1;


  int _ultimoItem = 0;
  bool _isLoading = false;


  @override
  void initState() { 
    super.initState();

    _agregar30();
    _scrollController.addListener((){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listas')),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading()
        ],
      ),
    );
  }

  Widget _crearLista() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _ListaNumeros.length,
      itemBuilder: (BuildContext context, int index){

          final imagen = _ListaNumeros30[countPerIteration];
          countPerIteration++;
          if(countPerIteration==10){
            countPerIteration = 0;
          }

          if(index % 10 == 0 && index != 0){
            determineWhichPhoto++;
            if(determineWhichPhoto==4){
              determineWhichPhoto=1;
            }
          }

          switch(determineWhichPhoto){
            case 1:
              return FadeInImage(
                image: NetworkImage('https://picsum.photos/id/$imagen/500/300/'),
                placeholder: AssetImage('assets/jar-loading.gif'),
              );
            case 2:
            return FadeInImage(
              image: NetworkImage('https://picsum.photos/id/$imagen/500/300?blur'),
              placeholder: AssetImage('assets/jar-loading.gif'),
            );

            case 3:
            return FadeInImage(
              image: NetworkImage('https://picsum.photos/id/$imagen/500/300?grayscale'),
              placeholder: AssetImage('assets/jar-loading.gif'),
            );

          }

          
      },
    );
  }


  Future<Null> fetchData() async{
    _isLoading = true;
    setState(() {});
    final duracion = new Duration(seconds: 3);
    return new Timer(duracion, responseHTTP);
  }

  void responseHTTP() {
    _isLoading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 150,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
      );
    _agregar30();
  }

  void _agregar10() {
    for (var i = 0; i < 10; i++) {
      //_ultimoItem++;
      _ListaNumeros.add(_ultimoItem++);
      setState(() {});
    }
  }


  void _agregar30() {
      for (var i = 0; i < 30; i++) {
        //_ultimoItem++;
        if(_ultimoItem <= 9){
              _ListaNumeros.add(_ultimoItem++);
            }
            else if(_ultimoItem >= 10 && _ultimoItem <= 19){
              _ListaNumeros.add((_ultimoItem++)-10);
            }
            else if(_ultimoItem >= 20 && _ultimoItem <= 29){
              _ListaNumeros.add((_ultimoItem++)-20);
                
            }
            
            if(_ultimoItem == 29){
                _ultimoItem = 0;
              }
        setState(() {});
      }
  }

  Widget _crearLoading() {
    if(_isLoading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          )
        ],
      );
    }
    return Container();
  }

}

 