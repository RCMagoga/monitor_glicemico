import 'package:monitor_glicemico/models/coleta.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db _db = Db._internal();

  factory Db() {
    return _db;
  }

  Db._internal();

  Future<Database> openDb() async {
    String dbDirPath = await getDatabasesPath();
    String dbPath = '$dbDirPath/save.db';
    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE coletas (id INTEGER PRIMARY KEY, data DATE, jejum INTEGER, almoco INTEGER, jantar INTEGER)");
      },
    );
    return db;
  }

  Future<int> salvarColeta(Coleta coleta) async{
    Database db = await openDb();
    int resposta = -1;
    if (db.isOpen) {
      
      resposta = 0;
    }
    db.close();
    return resposta;
  }

  void buscarColetas() {}
}
