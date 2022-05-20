import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:todo_list/task/task_model.dart';
import 'package:todo_list/util/dialogs_widget.dart';

class TaskController {

  void closeTaskController(){
    _controllerTasks.close();
  }

  final TextEditingController textTaskController = TextEditingController();

  final BehaviorSubject<List<Task>> _controllerTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get streamControllerTasks => _controllerTasks.stream;

  final BehaviorSubject<List<Task>> _controllerSelectedTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get streamControllerSelectedTasks => _controllerSelectedTasks.stream;

  void initTaskPage(){
    _controllerTasks.sink.add([]);
    _controllerSelectedTasks.sink.add([]);
  }

  void addTask(BuildContext context){
    if(textTaskController.text.isNotEmpty){
      var tasks = _controllerTasks.stream.value;
      var dateFormat = DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now());
      tasks.add(Task(date: dateFormat, task: textTaskController.text, done: false));
      _controllerTasks.sink.add(tasks);
      textTaskController.clear();
    }
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void deleteSelectedTasks(BuildContext context, List<Task> oldTasks, List<Task> selectedTasks){
    List<Task> updatedTasks = []; updatedTasks.addAll(oldTasks);
    for(var task in selectedTasks) {
      updatedTasks.remove(task);
    }
    _controllerTasks.sink.add(updatedTasks);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.black,
        content: const Text("Tarefas excluídas com sucesso!"),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () => _controllerTasks.sink.add(oldTasks),
        ),
      ),
    );
  }

  void completeSelectedTasks(List<Task> tasks, List<Task> selectedTasks){
    for(var task in tasks){
      for(var selectedTask in selectedTasks){
        if(task == selectedTask){
          task.done = true;
          task.editing = false;
        }
      }
    }
    _controllerTasks.sink.add(tasks);
    _controllerSelectedTasks.sink.add([]);
  }

  Future<void> deleteAllTasks(BuildContext context) async {
    bool? deleteTasks = await showDialog(context: context, builder: (_) => dialogDeleteAllTasksConfirmation(context));
    if(deleteTasks ?? false){
      _controllerTasks.sink.add([]);
    }
  }

  void selectTaskItem(Task task, bool? editing){
    var selectedItems = _controllerSelectedTasks.stream.value;
      task.editing = editing ?? false;
    if(editing ?? false){
      selectedItems.add(task);
    } else{
      selectedItems.remove(task);
    }
    _controllerSelectedTasks.sink.add(selectedItems);
  }
}