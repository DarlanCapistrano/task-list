import 'package:intl/intl.dart';
import 'package:my_tasks/db/database_provider.dart';
import 'package:my_tasks/my_tasks/my_tasks_model.dart';
import 'package:sqflite/sqflite.dart';

class MyTasksRepository {
  late Database _database;

  Future<void> initRepository() async{
    _database = await DBProvider.db.database;
  }

  Future<List<Task>> findAllTasks() async => Task.fromMapToList(await _database.rawQuery("SELECT * FROM tasks"));

  Future<void> insertTask(String task) async{
    await _database.insert("tasks", {
      "task" : task,
      "createdDate" : DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()),
      "done" : 0,
    });
  }

  Future<void> reinsertDeletedTasks(List<Task> tasks) async{
    for(var task in tasks){
      await _database.insert("tasks", {
        "id": task.id,
        "task": task,
        "createdDate": task.createdDate,
        "done": task.done,
      });
    }
  }

  Future<void> completeTask(Task task) async => await _database.rawUpdate("UPDATE tasks SET done = 1 WHERE id = ${task.id}");

  Future<void> deleteTask(Task task) async => await _database.rawDelete("DELETE FROM tasks WHERE id = ${task.id}");

  Future<void> deleteAllTasks() async => await _database.rawDelete("DELETE FROM tasks");
}