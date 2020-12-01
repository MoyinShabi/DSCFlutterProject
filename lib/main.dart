import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple ToDos",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List todos = [];
  final textController = TextEditingController();

  /// Function to display a Dialog when the FAB is pressed
  displayDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Todo'),
          content: TextField(
            controller: textController,
            autofocus: true,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          actions: [
            TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                  textController.clear();
                }),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final todo = textController.value.text;

                if (todo != null) {
                  setState(() {
                    todos.add(todo);
                  });
                }
                textController.clear();
                Navigator.of(context).pop(todo);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: GradientText(
          'TODOs',
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 40.0,
            color: Colors.black,
          ),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, index) {
          return TodoTile(
            todoText: todos.toString(),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
              )),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          displayDialog();
        },
        tooltip: 'Add',
      ),
    );
  }
}

class TodoTile extends StatefulWidget {
  const TodoTile({
    this.key,
    @required this.todoText,
  });
  final Key key;
  final String todoText;

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.todoText ?? "",
          style: TextStyle(
            color: Colors.black,
            decoration: checked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = value;
              });
            }),
      ),
    );
  }
}
