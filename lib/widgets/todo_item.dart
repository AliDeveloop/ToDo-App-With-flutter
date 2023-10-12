import 'package:flutter/material.dart';

import 'package:todo/model/todo.dart';
import 'package:todo/constants/colors.dart';

class ToDoitem extends StatelessWidget {
  final ToDo todo;
  final ontodochange;
  final ondeleteitem;

  const ToDoitem(
      {Key? key,
      required this.todo,
      required this.ondeleteitem,
      required this.ontodochange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          // print("object");
          ontodochange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ?? false
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: tdblue,
        ),
        title: Text(
          todo.todotext!,
          style: TextStyle(
            fontSize: 16,
            color: tdblack,
            decoration:
                (todo.isDone ?? false) ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: tdred, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              ondeleteitem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
