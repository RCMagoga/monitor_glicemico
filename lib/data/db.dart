import 'package:sqflite/sqflite.dart';

class Db {
  static Future<Database> openDb() async {
    var dbPath = getDatabasesPath();
    String path = "$dbPath + /database.db";

    //await deleteDatabase(path);

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE coletas (id INTEGER PRIMARY KEY, data DATE, jejum INTEGER, almoco INTEGER, jantar INTEGER)");
      },
    );
    return db;
  }

  static void salvarColeta() async {
    Database db = await openDb();

    await db.transaction(
      (txn) async {
        await txn.rawInsert(
            "INSERT INTO coletas(data, jejum, almoco, jantar) VALUES ('27/12/2024', 96, 122, 126)");
      },
    );

    db.close();
  }

  static Future<List<Map>> buscarColetas() async{
    Database db = await openDb();
    List<Map> lista = await db.rawQuery("SELECT * FROM coletas ORDER BY data ASC");
    return lista;
  }

}
