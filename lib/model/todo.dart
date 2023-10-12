class ToDo {
  String? id;
  String? todotext;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });

  static List<ToDo> todolist() {
    return [
      ToDo(id: '1', todotext: "Buy Loptop"),
      ToDo(id: '2', todotext: "Team Meating"),
      ToDo(id: '3', todotext: "Check Emaiils", isDone: true),
      ToDo(id: '4', todotext: "Buy Loptop"),
      ToDo(id: '5', todotext: "Team Meating"),
      ToDo(id: '6', todotext: "Check Emaiils", isDone: true),
    ];
  }
}
