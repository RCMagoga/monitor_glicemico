import 'package:sqflite/sqflite.dart';

class Db {
  
  static final Db _singleton = Db._interval();

  factory Db(){
    return _singleton;
  }

  Db._interval();

  void salvarColeta(){

  }

  void buscarColetas(){
    
  }

}