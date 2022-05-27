class Task {
  final int id;
  final String createdDate;
  final String task;
  final bool done;
  bool editing;

  Task({required this.id, required this.createdDate, required this.task, required this.done, this.editing = false});

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map["id"],
      createdDate: map["createdDate"],
      task: map["task"],
      done: map["done"] == 1,
    );
  }

  static List<Task> fromMapToList(List<Map<String, dynamic>> maps){
    return maps.map((e) => Task.fromMap(e)).toList();
  }
}