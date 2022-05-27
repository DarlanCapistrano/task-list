import 'package:flutter/material.dart';
import 'package:task_list/main_app/main_app_controller.dart';
import 'package:task_list/task/task_controller.dart';
import 'package:task_list/task/task_model.dart';
import 'package:task_list/util/color_theme.dart';
import 'package:task_list/util/dialogs_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskController _taskController = TaskController();

@override
  void initState() {
    _taskController.initTaskPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return streamAppTheme(context);
  }

  Widget streamAppTheme(BuildContext context){
    return StreamBuilder(
      stream: MainController().controllerAppTheme.stream,
      builder: (context, snapshot) => bodyTaskPage(context),
    );
  }

  Widget bodyTaskPage(BuildContext context){
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorsApp.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(context),
              addTaskWidgets(context),
              streamTasks(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Minhas Tarefas", style: TextStyle(fontSize: 28, color: ColorsApp.secondaryColor)),
        IconButton(
          onPressed: () async => await showDialog(context: context, builder: (_) => const DialogOpenSettings()),
          icon: Icon(Icons.settings, color: ColorsApp.secondaryColor),
        ),
      ],
    );
  }

  Widget addTaskWidgets(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: ColorsApp.widgetsColor,
              controller: _taskController.textTaskController,
              style: TextStyle(color: ColorsApp.secondaryColor),
              decoration: InputDecoration(
                labelText: "Adicione uma tarefa",
                labelStyle: TextStyle(color: ColorsApp.secondaryColor),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.secondaryColor)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.secondaryColor)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _taskController.addTask(context),
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(primary: ColorsApp.widgetsColor, fixedSize: const Size(60, 60)),
          ),
        ],
      ),
    );
  }

  Widget streamTasks(BuildContext context){
    return StreamBuilder<List<Task>>(
      stream: _taskController.streamControllerTasks,
      initialData: const [],
      builder: (context, snapshot) => streamSelectedTasks(context, snapshot.data!),
    );
  }

  Widget streamSelectedTasks(BuildContext context, List<Task> tasks){
    return StreamBuilder<List<Task>>(
      stream: _taskController.streamControllerSelectedTasks,
      initialData: const [],
      builder: (context, snapshot) => tasksWidget(context, tasks, snapshot.data!),
    );
  }

  Widget tasksWidget(BuildContext context, List<Task> tasks, List<Task> selectedTasks){
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: true,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) => toDoItem(context, tasks[index]),
              ),
            ),
          ),
          if(tasks.isNotEmpty)
            bottomWidgets(context, tasks, selectedTasks),
        ],
      ),
    );
  }

  Widget toDoItem(BuildContext context, Task toDo){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(toDo.date, style: TextStyle(color: ColorsApp.tertiaryColor)),
                    const SizedBox(height: 4),
                    Text(toDo.task, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: toDo.done ? Colors.green[600] : ColorsApp.secondaryColor, decoration: toDo.done ? TextDecoration.lineThrough : null)),
                  ],
                ),
              ),
              Checkbox(
                side: BorderSide(color: ColorsApp.tertiaryColor, width: 2),
                activeColor: ColorsApp.widgetsColor,
                value: toDo.editing,
                onChanged: (newValue) => _taskController.selectTaskItem(toDo, newValue),
              ),
            ],
          ),
        ),
        Container(height: 1, width: double.maxFinite, color: Colors.grey[300], margin: const EdgeInsets.all(12)),
      ],
    );
  }

  Widget bottomWidgets(BuildContext context, List<Task> tasks, List<Task> selectedTasks){
    if(selectedTasks.isEmpty){
      List<Task> doneTasks = tasks.where((e) => e.done).toList();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${doneTasks.length} de ${tasks.length} tarefas concluídas", style: TextStyle(fontSize: 16, color: ColorsApp.tertiaryColor)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: ColorsApp.widgetsColor),
            onPressed: () => tasks.isEmpty ? null : _taskController.deleteAllTasks(context),
            child: const Text("Limpar tudo"),
          ),
        ],
      );
    } else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(fixedSize: const Size(80, 0)),
            child: Text("Excluir", textAlign: TextAlign.center, style: TextStyle(color: ColorsApp.secondaryColor)),
            onPressed: tasks.isEmpty ? null : () => _taskController.deleteSelectedTasks(context, tasks, selectedTasks),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: ColorsApp.widgetsColor),
            child: const Text("Concluir"),
            onPressed: () => tasks.isEmpty ? null : _taskController.completeSelectedTasks(tasks, selectedTasks),
          ),
        ],
      );
    }
  }
}