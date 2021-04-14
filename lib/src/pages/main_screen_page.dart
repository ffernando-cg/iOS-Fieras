import 'dart:async';

import 'package:app_leon_project/src/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
    ListView(
      children: <Widget>[
        Text(
        'My PagoBus',
        style: optionStyle,
      ),
      ]
    ),
    ListView(
      children: <Widget>[
        Text(
        'Profile',
        style: optionStyle,
      ),
      ]
    ),
    ListView(
      children: <Widget>[
        Text(
        'FeedBack?',
        style: optionStyle,
      ),
      ]
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
            label: 'Map and Routes',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert),
            label: 'My PagoBus',
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
            backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_sharp),
            label: 'Feedback?',
            backgroundColor: Colors.orangeAccent
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[400],
        onTap: _onItemTap,
      ),
    );
  }
}