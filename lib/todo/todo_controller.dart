import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:todo_list/todo/todo_model.dart';
import 'package:todo_list/util/dialogs_widget.dart';

class ToDoController {

  void closeToDoController(){
    _controllerToDoList.close();
  }

  final TextEditingController textToDoController = TextEditingController();

  final BehaviorSubject<List<ToDo>> _controllerToDoList = BehaviorSubject<List<ToDo>>();
  Stream<List<ToDo>> get streamControllerToDoList => _controllerToDoList.stream;

  void initToDoPage(){
    _controllerToDoList.sink.add([]);
  }

  void addToDoItem(){
    if(textToDoController.text.isNotEmpty){
      var toDoList = _controllerToDoList.stream.value;
      var dateFormat = DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now());
      toDoList.add(ToDo(date: dateFormat, todo: textToDoController.text, done: false));
      _controllerToDoList.sink.add(toDoList);
      textToDoController.clear();
    }
  }

  void deleteToDoItem(BuildContext context, ToDo toDo){
    var toDoList = _controllerToDoList.stream.value;
    var deletedToDoPos = toDoList.indexOf(toDo);
    toDoList.remove(toDo);
    _controllerToDoList.sink.add(toDoList);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.black,
        content: Text("Tarefa ${toDo.todo} foi excluída!"),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: (){
            toDoList.insert(deletedToDoPos, toDo);
            _controllerToDoList.sink.add(toDoList);
          },
        ),
      ),
    );
  }

  Future<void> deleteToDoList(BuildContext context) async {
    bool? deleteTasks = await showDialog(context: context, builder: (_) => dialogDeleteAllToDoListConfirmation(context));
    if(deleteTasks ?? false){
      _controllerToDoList.sink.add([]);
    }
  }

}