import 'dart:io';
import 'package:app_leon_project/src/providers/firebase_storage_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class PagoBusPage extends StatefulWidget {
  @override
  _PagoBusPageState createState() => _PagoBusPageState();
}


String urlString = 'https://www.sat.gob.mx/personas';

class _PagoBusPageState extends State<PagoBusPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _fechaVencimiento;

  TextEditingController _pathController = new TextEditingController();
  String _path = '-';
  bool _pickFileInProgress = false;
  bool _iosPublicDataUTI = true;
  bool _checkByCustomExtension = false;
  bool _checkByMimeType = false;
  bool _isFileUploaded = false;

  bool _isPagoBusExpired = false;

  final _utiController = TextEditingController(
    text: 'com.sidlatau.example.mwfbak',
  );

  final _extensionController = TextEditingController(
    text: 'mwfbak',
  );

  final _mimeTypeController = TextEditingController(
    text: 'application/pdf image/png',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final User user = _auth.currentUser;
      final uid = user.uid; 
      _firestore.collection('usuariosLeon').doc(uid).get().then((value) {
            var currentData = value.data();
              setState(() {
                _fechaVencimiento = currentData["fechavencimiento"];
              });
            }
        );

        Future uploadDocs(File document)async{
          setState(() {
            _pickFileInProgress = true;
          });
            if(document == null) return;
            final fileName = document.path.split('/').last;
            final destination = '$uid/$fileName';

            try{
            FirebaseApi.uploadFile(destination, document);
        
          var referencedFecha = _fechaVencimiento.split('/').first + '/' +_fechaVencimiento.split('/')[1];
          int newExpiredDate = int.parse(_fechaVencimiento.split('/').last) + 1;
           var newfechaVencimiento= '$referencedFecha/$newExpiredDate';  
          print(newfechaVencimiento);


            FirebaseStorage.instance.ref(destination).getDownloadURL()
              .then((url){
                  setState(() {
                    _isFileUploaded = true;
                    _path = url;
                    urlString = _path;
                    _pickFileInProgress = false;
                  });
                  sleep(Duration(seconds:5));
              }).then((value) => 
              _firestore.collection('usuariosLeon').doc(uid).update({
                    "fechavencimiento": newfechaVencimiento
              })
              );
            }catch(val) {
              print(val);
            }
        }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Mi Pago Bus'),
          actions: [
            IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: (){
              File document = File(_path);
              uploadDocs(document);
            },
          )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tu pago bus vence el día:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '$_fechaVencimiento',
                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                _isPagoBusExpired ? _expiredText() : Container(),
                _pickFileInProgress ? CircularProgressIndicator() : Container(),
                Theme.of(context).platform == TargetPlatform.iOS
                    ? _buildIOSParams()
                    : _buildAndroidParams(),

                _isFileUploaded ? _showButtonForUploadedDocument() : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _pickFileInProgress ? null : _pickDocument,
        ),
      );
  }

  Widget _showButtonForUploadedDocument() {
    return ElevatedButton(
      onPressed: _launchURL, 
      child: Text('Ver documento subido')
      );
  }

  Widget _expiredText(){
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.grey[300],
        
      ),
      child: Text(
        'Por favor anexa los documentos requeridos para renovar tu PagoBus, hasta entonces, la cuenta permanecerá inhabil hasta su renovación',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange[400],
        ),
      ),
    );
  }


  _pickDocument() async {
    String result;
    try {
      setState(() {
        _path = '-';
        _pickFileInProgress = true;
      });

      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: _checkByCustomExtension
            ? _extensionController.text
                .split(' ')
                .where((x) => x.isNotEmpty)
                .toList()
            : null,
        allowedUtiTypes: _iosPublicDataUTI
            ? null
            : _utiController.text
                .split(' ')
                .where((x) => x.isNotEmpty)
                .toList(),
        allowedMimeTypes: _checkByMimeType
            ? _mimeTypeController.text
                .split(' ')
                .where((x) => x.isNotEmpty)
                .toList()
            : null,
      );

      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {
      setState(() {
        _pickFileInProgress = false;
      });
    }

    setState(() {
      _path = result;
      _pathController.text = _path;
    });
  }

  _buildIOSParams() {
    return Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Sus archivos:',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Estos archivos solo serán vistos por un representante de PagoBus, se mantendrán de forma confidencial. \n Favor de no subir archivos externos a los solicitados, de no respetar esta regla, la cuenta será suspendida \n\t Para más información visite:',
                        softWrap: true,
                        style: TextStyle(
                          fontStyle: FontStyle.italic, 
                          fontSize: 10,
                          color: Colors.grey
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  child: Text('Más información'),
                  onTap: () => _launchURL
                ),
              ),
          Container(
               child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  controller: _pathController,
                  decoration: InputDecoration(
                    isDense: true,                      // Added this
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(15),
                    hintText: '...'
                  ),
                ),
          )
            ],
          ),
        ),
      ),
    );
  }

  _buildAndroidParams() {
    return Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Sus archivos:',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Estos archivos solo serán vistos por un representante de PagoBus, se mantendrán de forma confidencial. \n Favor de no subir archivos externos a los solicitados, de no respetar esta regla, la cuenta será suspendida \n\t Para más información visite:',
                        softWrap: true,
                        style: TextStyle(
                          fontStyle: FontStyle.italic, 
                          fontSize: 10,
                          color: Colors.grey
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  child: Text('Más información'),
                  onTap: () => _launchURL
                ),
              ),
          Container(
               child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  controller: _pathController,
                  decoration: InputDecoration(
                    isDense: true,                      // Added this
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(15),
                    hintText: '...'
                  ),
                ),
          )
            ],
          ),
        ),
      ),
    );
  }

}


void _launchURL() async =>
  await canLaunch(urlString) ? await launch(urlString) : throw 'Could not launch';

//  Future<String>
