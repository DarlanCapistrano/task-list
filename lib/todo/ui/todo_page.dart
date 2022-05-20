import 'package:flutter/material.dart';
import 'package:todo_list/todo/todo_controller.dart';
import 'package:todo_list/todo/todo_model.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final ToDoController _toDoController = ToDoController();

@override
  void initState() {
    _toDoController.initToDoPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Minhas Tarefas", style: TextStyle(fontSize: 28, color: Colors.black)),
              addToDoItem(context),
              streamToDoList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget addToDoItem(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _toDoController.textToDoController,
              decoration: const InputDecoration(
                labelText: "Adicione uma tarefa",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _toDoController.addToDoItem(),
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(fixedSize: const Size(60, 60)),
          ),
        ],
      ),
    );
  }

  Widget streamToDoList(BuildContext context){
    return StreamBuilder<List<ToDo>>(
      stream: _toDoController.streamControllerToDoList,
      initialData: const [],
      builder: (context, snapshot) => toDoList(context, snapshot.data!),
    );
  }

  Widget toDoList(BuildContext context, List<ToDo> toDoList){
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: true,
              child: ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: (context, index) => toDoItem(context, toDoList[index]),
              ),
            ),
          ),
          if(toDoList.isNotEmpty)
            bottomWidgets(context, toDoList),
        ],
      ),
    );
  }

  Widget toDoItem(BuildContext context, ToDo toDo){
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(toDo.date),
                    const SizedBox(height: 4),
                    Text(toDo.todo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // IconButton(onPressed: () => _toDoController.deleteToDoItem(context, toDo), icon: const Icon(Icons.delete, color: Colors.red), padding: const EdgeInsets.all(0)),
            ],
          ),
        ),
        Container(height: 1, width: double.maxFinite, color: Colors.grey[300], margin: const EdgeInsets.all(12)),
      ],
    );
  }

  Widget bottomWidgets(BuildContext context, List<ToDo> toDoList){
    List<ToDo> doneToDoList = toDoList.where((e) => e.done).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${doneToDoList.length} de ${toDoList.length} tarefas concluídas", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ElevatedButton(onPressed: () => toDoList.isEmpty ? null : _toDoController.deleteToDoList(context), child: const Text("Limpar tudo")),
      ],
    );
  }
}