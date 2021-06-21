import 'package:app_leon_project/src/pages/myprofile_page.dart';
import 'package:app_leon_project/src/pages/pagobus_page.dart';
import 'package:app_leon_project/src/providers/map_provider.dart';
import 'package:flutter/material.dart';


class MainScreenPage extends StatefulWidget {
  MainScreenPage({Key key}) : super(key: key);

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
    int _selectedIndex = 0;
    static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


    static List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: MapProvider()
    ),
    Scaffold(
      body: PagoBusPage()
    ),
    Scaffold(
      body: MyProfilePage()
    ),
  ];

  void _onItemTap(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapas y Rutas',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert),
            label: 'Mi PagoBus',
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi Perfil',
            backgroundColor: Colors.orange
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[400],
        onTap: _onItemTap,
      ),
    );
  }
  }


  