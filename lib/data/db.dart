import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitor_glicemico/models/coleta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db extends ChangeNotifier{
  // Usado para criar um padrão Singleton, pois métodos estáticos não recebe parâmetro.
  static final Db _db = Db._internal();

  factory Db() {
    return _db;
  }

  Db._internal();

  Future<Database> openDb() async {
    String dbDirPath = await getDatabasesPath();
    String dbPath = join(dbDirPath, "save.db");
    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db
            .execute(
          "CREATE TABLE coletas (id INTEGER PRIMARY KEY, data TIMESTAMP, jejum INTEGER, almoco INTEGER, jantar INTEGER, obsJejum TEXT, obsAlmoco TEXT, obsJantar TEXT)",
        );
      },
    );
    return db;
  }

  Future<int> salvarColeta(Coleta coleta, String atualizaPeriodo) async {
    Database db = await openDb();
    // Armazena o retorna para mostrar msg para o usuário
    int resposta = -1;
    DateFormat formatacaoSalvar = DateFormat('yyyy-MM-dd');
    // Faz a busca pela data para escolher entre criar novo dado ou inserir um novo
    List<Map> busca = await db.rawQuery(
      "SELECT * FROM coletas WHERE data = ?",
      [formatacaoSalvar.format(coleta.data)],
    );
    // Insere um dado novo no Db, caso a 'busca' esteja vazia
    if (db.isOpen && busca.isEmpty) {
      await db.transaction(
        (txn) async {
          resposta = await txn.rawInsert(
            "INSERT INTO coletas(data, jejum, almoco, jantar, obsJejum, obsAlmoco, obsJantar) VALUES (?, ?, ?, ?, ?, ?, ?)",
            [
              formatacaoSalvar.format(coleta.data),
              coleta.jejum,
              coleta.almoco,
              coleta.jantar,
              coleta.obsJejum,
              coleta.obsAlmoco,
              coleta.obsJantar
            ],
          );
        },
      );
    // Faz a alteração de um dado já existente, caso a busca seja diferente de 0
    } else {
      String sql = "";
      List<dynamic> alteracoesSQL = ["", "", formatacaoSalvar.format(coleta.data)];
      if (atualizaPeriodo == "Jejum") {
        sql = "UPDATE coletas SET jejum = ?, obsJejum = ? WHERE data = ?";
        alteracoesSQL[0] = coleta.jejum;
        alteracoesSQL[1] = coleta.obsJejum;
      } else if (atualizaPeriodo == "Almoço") {
        sql = "UPDATE coletas SET almoco = ?, obsAlmoco = ? WHERE data = ?";
        alteracoesSQL[0] = coleta.almoco;
        alteracoesSQL[1] = coleta.obsAlmoco;
      } else {
        sql = "UPDATE coletas SET jantar = ?, obsJantar = ? WHERE data = ?";
        alteracoesSQL[0] = coleta.jantar;
        alteracoesSQL[1] = coleta.obsJantar;
      }
      await db.transaction(
        (txn) async {
          resposta = await txn.rawUpdate(sql,alteracoesSQL);
        },
      );
    }
    db.close();
    notifyListeners();
    return resposta;
  }

  Future<List<Map>> buscarColetas() async {
    Database db = await openDb();
    List<Map> lista = await db.rawQuery("SELECT * FROM coletas ORDER BY data");
    db.close();
    return lista;
  }

  void deletarDb() async {
    Database db = await openDb();
    await deleteDatabase(db.path);
  }
}
