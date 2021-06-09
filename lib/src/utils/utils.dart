bool isNumeric(String s){
  // Saber si es vacio
  if(s.isEmpty) return false;

  final n =  num.tryParse(s);
  return (n==null) ? false: true;
}