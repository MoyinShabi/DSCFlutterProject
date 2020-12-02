import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  textController.clear();
                }),
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(fontSize: 16.0),
              ),
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
            fontFamily: 'SFProRounded',
            fontSize: 42.0,
            color: Colors.black,
          ),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
      ),
      body: todos.isEmpty
          ? Center(
              child: Container(
                child: GradientText(
                  "Click the + button to add a todo",
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.blue],
                  ),
                ),
              ),
            )
          : ListView.separated(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, index) {
                final item = todos[index];
                return Dismissible(
                  key: Key(item),
                  //Specifies the direction of swipe to delete
                  direction: DismissDirection.endToStart,
                  // Deletes an item on the list, on swipe
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "$item Deleted",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            setState(() {
                              todos.insert(index, item);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25.0),
                    child: Icon(
                      Icons.delete_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  child: TodoTile(
                    todoText: todos[index],
                  ),
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
    return ListTile(
      title: Text(
        widget.todoText ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
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
    );
  }
}

/* TODO: 
1. Move checkboxes to leading
2. Learn & use `Hive` to (re)implement the following:
 -Adding Todos
 -Deleting Todos
 -Editing Todos (by pressing ListTile trailing) (in the same AlertDialog)
 -Data persistence- Retaining added Todos after app has been closed(storing them locally)
 -Sorting Todos(PopupMenuButton in AppBar actions):
  -All(Todos with all checked & unchecked checkboxes); 
  -Completed(Todos with only checked checkboxes);
  -Incompleted(Todos with only unchecked checkboxes)
3. See if all Todos can be made to be reordered
*/
