import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Autobuses {
  final int idRuta;
  final String nombre;
  final int recorrido;
  final String tipoRuta;
  final DocumentReference reference;


  Autobuses.fromMap(Map<String, dynamic> map, {this.reference})
          : assert(map['idRuta'] != null),
            assert(map['nombre'] != null),
            assert(map['recorrido'] != null),
            assert(map['tipoRuta'] != null),
            idRuta = map['idRuta'],
            nombre = map['nombre'],
            recorrido = map['recorrido'],
            tipoRuta = map['tipoRuta'];


  Autobuses.fromSnapshot(DocumentSnapshot snap)
    : this.fromMap(snap.data(), reference: snap.reference);
}