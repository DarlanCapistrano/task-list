import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static Database? _database;

  static final db = DBProvider._();

  final _initScripts = [
    "CREATE TABLE settings(appTheme TEXT)",
    "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, task TEXT, done INTEGER, createdDate TEXT)"
  ];

  Future<Database> get database async{
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async{
    final path = join(await getDatabasesPath(), "my_tasks.db");
    return await openDatabase(path, version: 1,
      onCreate: (db, version) {
        for (var script in _initScripts) {
          db.execute(script);
        }
      },
    );
  }
}