import 'dart:convert';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider{
  final String _url = 'https://flutterdb-82b03-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductModel producto) async{
    final url = Uri.http(_url, '/productos.json');

    final resp = await http.post(url,body: productModelToJson(producto));


    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }
}