import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]);
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
        title: Text(
          'TODOs',
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 40.0,
            color: Colors.black,
          ),
        ),
      ),
      body: todos.isEmpty
          ? Center(
              child: Container(
                child: Text("Click the + button to add a todo"),
              ),
            )
          : ReorderableListView(
              children: [
                for (final item in todos)
                  TodoTile(
                    todoText: item,
                    key: UniqueKey(),
                    onChanged: (bool) async {
                      if (bool) {
                        await Future.delayed(Duration(seconds: 2));
                        setState(() {
                          todos.remove(item);
                        });
                      }
                    },
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var getReplacedWidget = todos.removeAt(oldIndex);
                  todos.insert(newIndex, getReplacedWidget);
                });
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
    @required this.onChanged,
  });
  final Key key;
  final String todoText;
  final Function(bool) onChanged;
  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.todoText ?? "",
              style: TextStyle(
                color: Colors.black,
                decoration: checked ? TextDecoration.lineThrough : null,
              ),
            ),
            Checkbox(
                value: checked,
                onChanged: (value) {
                  setState(() {
                    checked = value;
                    widget.onChanged(value);
                  });
                })
          ],
        ),
      ),
    );
  }
}
