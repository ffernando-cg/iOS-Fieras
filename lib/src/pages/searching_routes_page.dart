import 'package:app_leon_project/src/providers/data_search_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchingRoutesPage extends StatefulWidget {
  SearchingRoutesPage({Key key}) : super(key: key);

  @override
  _SearchingRoutesPageState createState() => _SearchingRoutesPageState();
}


class _SearchingRoutesPageState extends State<SearchingRoutesPage> {
  SearchBar searchBar;
  DataSearchProvider _provider = new DataSearchProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  var dataFromFirestore = FirebaseFirestore.instance.collection('autobuses').snapshots();

  AppBar buildAppBar(BuildContext context) {
      return new AppBar(
          title: new Text('Todas las rutas'),
          actions: [searchBar.getSearchAction(context)]);
    }

  void onSubmitted(String value) {
      
    }

  _SearchingRoutesPageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body:  _provider.bringAllData(context)
    );
  }
}
