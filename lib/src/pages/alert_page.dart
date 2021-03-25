import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  AlertPage(this.cadenaBody);
  var cadenaBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: Text('$cadenaBody'),
    );
  }
}
