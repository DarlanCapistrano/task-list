import 'package:my_tasks/db/database_provider.dart';
import 'package:my_tasks/main_app/settings_model.dart';
import 'package:my_tasks/util/color_theme.dart';
import 'package:sqflite/sqflite.dart';

class MainRepository {
  late Database _database;

  Future<void> initRepository() async{
    _database = await DBProvider.db.database;
  }

  Future<void> insertDefaultSettings() async{
    await _database.insert("settings", {
      "appTheme": "white",
    });
  }

  Future<bool> hasSettings() async => (await _database.rawQuery("SELECT * FROM settings")).isNotEmpty;

  Future<Settings> findSettings() async => Settings.fromMap((await _database.rawQuery("SELECT * FROM settings")).first);

  Future<void> updateAppTheme(AppTheme theme) async {
    String appTheme = theme == AppTheme.white ? "white" : "dark";
    await _database.rawUpdate("UPDATE settings SET appTheme = '$appTheme'");
  }
}