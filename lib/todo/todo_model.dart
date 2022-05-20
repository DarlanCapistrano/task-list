class ToDo {
  final String date;
  final String todo;
  final bool done;

  ToDo({required this.date, required this.todo, required this.done});

  factory ToDo.fromMap(Map<String, dynamic> map){
    return ToDo(
      date: map["date"],
      todo: map["todo"],
      done: map["done"],
    );
  }
}