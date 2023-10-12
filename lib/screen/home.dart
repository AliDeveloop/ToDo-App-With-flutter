import 'package:flutter/material.dart';

import 'package:todo/model/todo.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = ToDo.todolist();
  List<ToDo> _foundtodo = [];
  final _todocontroller = TextEditingController();

  @override
  void initState() {
    _foundtodo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdbgcolor,
      appBar: AppBar(
        backgroundColor: tdbgcolor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdblack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(child: Image.asset('assets/images/avatar.png')),
            )
          ],
        ),
      ),
      // ! end app bar
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                serachBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 50),
                        child: Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundtodo.reversed)
                        ToDoitem(
                          todo: todoo,
                          ontodochange: _handeltodochange,
                          ondeleteitem: _deletetodoitem,
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, right: 20, left: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todocontroller,
                          decoration:
                              InputDecoration(hintText: "Add a new todo item"),
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20),
                        child: ElevatedButton(
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 40),
                          ),
                          onPressed: () {
                            _todoliadditem(_todocontroller.text);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: tdblue,
                              minimumSize: Size(50, 50),
                              elevation: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handeltodochange(ToDo todo) {
    setState(() {});
    bool isDone = todo.isDone ?? false;
    todo.isDone = !isDone;
  }

  void _deletetodoitem(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void _todoliadditem(String todotext) {
    setState(() {
      todolist.add(
          ToDo(id: DateTime.now().millisecond.toString(), todotext: todotext));
    });
    _todocontroller.clear();
  }

  void _runfilter(String enteredkeyword) {
    List<ToDo> results = [];
    if (enteredkeyword.isEmpty) {
      results = todolist;
    } else {
      results = todolist
          .where((item) => item.todotext!
              .toLowerCase()
              .contains(enteredkeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundtodo = results;
    });
  }

  Widget serachBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: (15)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runfilter(value), // تغییر اینجا
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "search",
            hintStyle: TextStyle(color: tdgray)),
      ),
    );
  }
}
