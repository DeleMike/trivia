import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

///[DbHelper] - Opens SQLite functions to the app
class DbHelper {
  ///create DB
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'trivia.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, quizName TEXT, quizDifficulty TEXT, dateTaken TEXT, score TEXT)');
      },
      version: 1,
    );
  }

  ///insert data into DB
  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DbHelper.database();
    sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  ///fetch data from db
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DbHelper.database();
    return sqlDb.query(table);
  }
}
