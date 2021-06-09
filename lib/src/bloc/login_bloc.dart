import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/bloc/validators.dart';

class LoginBloc with Validators{ // Mezcla entre login bloc y validador
  // stream nos va a servir para controlar flujo y cambios en las propiedades de niveles bajos
  
 /*  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast(); */
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Necesitamos combinar los dos streams 
  get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<String>get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String>get passwordStream => _passwordController.stream.transform(validarPassword);


  Function(String) get changeEmail => _emailController.sink.add; // crear un referencia
  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}