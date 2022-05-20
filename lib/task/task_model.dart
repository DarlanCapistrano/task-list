class Task {
  final String date;
  final String task;
  // switch here
  // final bool done;
  bool done;
  bool editing;

  Task({required this.date, required this.task, required this.done, this.editing = false});

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      date: map["date"],
      task: map["todo"],
      done: map["done"],
    );
  }
}