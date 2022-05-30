import 'package:flutter/material.dart';
import 'package:my_tasks/my_tasks/my_tasks_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:my_tasks/my_tasks/my_tasks_model.dart';
import 'package:my_tasks/util/color_theme.dart';
import 'package:my_tasks/util/dialogs_widget.dart';

class MyTasksController {

  final MyTasksRepository _myTasksRepository = MyTasksRepository();

  void closeMyTaskController(){
    _controllerTasks.close();
    _controllerSelectedTasks.close();
  }

  final TextEditingController textTaskController = TextEditingController();

  final BehaviorSubject<List<Task>> _controllerTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get streamControllerTasks => _controllerTasks.stream;

  final BehaviorSubject<List<Task>> _controllerSelectedTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get streamControllerSelectedTasks => _controllerSelectedTasks.stream;

  Future<void> initMyTasksPage() async{
    await _myTasksRepository.initRepository();
    var tasks = await _myTasksRepository.findAllTasks();
    _controllerTasks.sink.add(tasks);
    _controllerSelectedTasks.sink.add([]);
  }

  Future<void> addTask(BuildContext context) async{
    var text = textTaskController.text.trim();
    if(text.isNotEmpty){
      await _myTasksRepository.insertTask(text);
      List<Task> tasks = await _myTasksRepository.findAllTasks();
      _controllerTasks.sink.add(tasks);
      textTaskController.clear();
    }
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  Future<void> deleteSelectedTasks(BuildContext context, List<Task> oldTasks, List<Task> selectedTasks) async{
    for(var task in selectedTasks) {
      await _myTasksRepository.deleteTask(task);
    }
    List<Task> tasks = await _myTasksRepository.findAllTasks();
    _controllerTasks.sink.add(tasks);
    _controllerSelectedTasks.sink.add([]);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: ColorsApp.secondaryColor,
        content: Text("Tarefas excluídas com sucesso!", style: TextStyle(color: ColorsApp.primaryColor)),
        action: SnackBarAction(
          textColor: ColorsApp.widgetsColor,
          label: "Desfazer",
          onPressed: () async {
            await _myTasksRepository.reinsertDeletedTasks(selectedTasks);
            tasks = await _myTasksRepository.findAllTasks();
            _controllerTasks.sink.add(tasks);
            _controllerSelectedTasks.sink.add([]);
          },
        ),
      ),
    );
  }

  Future<void> completeSelectedTasks(List<Task> tasks, List<Task> selectedTasks) async{
    for(var selectedTask in selectedTasks){
      await _myTasksRepository.completeTask(selectedTask);
    }
    List<Task> tasks = await _myTasksRepository.findAllTasks();
    _controllerTasks.sink.add(tasks);
    _controllerSelectedTasks.sink.add([]);
  }

  Future<void> deleteAllTasks(BuildContext context) async {
    bool? delete = await showDialog(context: context, builder: (_) => dialogDeleteAllTasksConfirmation(context));
    if(delete ?? false){
      _myTasksRepository.deleteAllTasks();
      _controllerTasks.sink.add([]);
    }
  }

  void selectTaskItem(Task task, bool? editing){
    var selectedItems = _controllerSelectedTasks.stream.value;
      task.editing = editing ?? false;
    if(task.editing){
      selectedItems.add(task);
    } else{
      selectedItems.remove(task);
    }
    _controllerSelectedTasks.sink.add(selectedItems);
  }
}