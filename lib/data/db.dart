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

  static Future<void> salvarColeta(String date, jejum, almoco, jantar) async {
    Database db = await openDb();

    List<Map> busca =
        await db.rawQuery("SELECT * FROM coletas WHERE data = ?", [date]);

    if (busca.isNotEmpty) {
      if (jejum == 0) {
        jejum = busca.first['jejum'];
      } 
      if(almoco == 0){
        almoco = busca.first['almoco'];
      }
      if(jantar == 0){
        jantar = busca.first['jantar'];
      }
      await db.transaction(
        (txn) async {
          await txn.rawUpdate(
              'UPDATE coletas SET jejum = ?, almoco = ?, jantar = ? WHERE data = ?',
              [jejum, almoco, jantar, date]);
        },
      );
    } else {
      await db.transaction(
        (txn) async {
          await txn.rawInsert(
              "INSERT INTO coletas(data, jejum, almoco, jantar) VALUES (?, ?, ?, ?)",
              [date, jejum, almoco, jantar]);
        },
      );
    }

    db.close();
  }

  static Future<List<Map>> buscarColetas() async {
    Database db = await openDb();
    List<Map> lista =
        await db.rawQuery("SELECT * FROM coletas ORDER BY data ASC");
    return lista;
  }

  static Future<int> deletarColeta(String data) async{
    Database db = await openDb();
    var resposta = await db.delete('coletas', where: 'data = ?', whereArgs: [data]);
    return resposta;
  }
}
