import 'package:flutter/material.dart';
import 'package:dip_taskplanner/database/model/Todo.dart';
import 'package:dip_taskplanner/database/database.dart';


class DetailTodoScreen extends StatefulWidget {
  static const routeName = '/detailTodoScreen';
  final Todo todo;

  const DetailTodoScreen({Key key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoState(todo);
}

class _CreateTodoState extends State<DetailTodoScreen> {
  Todo todo;
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

  _CreateTodoState(this.todo);

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      descriptionTextController.text = todo.content;
      titleTextController.text = todo.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo detail'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
              maxLines: 1,
              controller: titleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              maxLines: 10,
              controller: descriptionTextController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            _saveTodo(titleTextController.text, descriptionTextController.text);
            setState(() {});
          }),
    );
  }

  _saveTodo(String title, String content) async {
    if (todo == null) {
      DatabaseHelper.instance.insertTodo(Todo(
          title: titleTextController.text,
          content: descriptionTextController.text));
      Navigator.pushNamed(context, "home");
      print('insert testing');
      print(todo);
    } else {
      await DatabaseHelper.instance
          .updateTodo(Todo(id: todo.id, title: title, content: content));
      //Navigator.pop(context);
      Navigator.pushNamed(context, "home");
      print('update testing');
      print(todo);
    }
  }
}
