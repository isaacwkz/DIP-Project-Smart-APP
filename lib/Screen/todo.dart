import 'package:flutter/material.dart';
import 'package:dip_taskplanner/database/database.dart';
import 'package:dip_taskplanner/database/model/Todo.dart';
import 'package:dip_taskplanner/Screen/todoDetail.dart';

class todo extends StatefulWidget {
  @override
  _todoState createState() => _todoState();
}


class _todoState extends State<todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Todos'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: DatabaseHelper.instance.retrieveTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  leading: Text(snapshot.data[index].id.toString()),
                  subtitle: Text(snapshot.data[index].content),
                  onTap: () => _navigateToDetail(context, snapshot.data[index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _deleteTodo(snapshot.data[index]);
                        setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToCreateTodoScreen(context);
          },
          tooltip: 'Add Item',
          child: Icon(Icons.add)
      ),
    );
  }
}


_navigateToCreateTodoScreen(BuildContext context) async {
  // Navigator.push returns a Future that completes after calling
  // Navigator.pop on the Selection Screen.
  final result = await Navigator.push(
    context,
    // Create the SelectionScreen in the next step.
    MaterialPageRoute(builder: (context) => DetailTodoScreen()),
  );
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("$result")));
}

_deleteTodo(Todo todo) {
  DatabaseHelper.instance.deleteTodo(todo.id);
}

_navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailTodoScreen(todo: todo)),
  );
}

