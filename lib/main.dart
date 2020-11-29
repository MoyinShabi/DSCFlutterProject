import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
//Always put your variables inside a class
  List items = ["Item 1", "Item 2", "Item 3"];
  //Not useful you see
  // bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOs'),
      ),
      body: ReorderableListView(
        children: [
          for (final item in items)
            TodoTile(
              todoText: item,
              key: UniqueKey(),
            ),
          // CheckboxListTile(
          //   value: toggle,
          //   onChanged: (bool) {
          //     setState(() {
          //       if (!bool) {
          //         toggle = false;
          //       } else {
          //         toggle = true;
          //       }
          //     });
          //   },
          //   key: ValueKey(item),
          //   title: ToDoTile(
          //     todoText: item,
          //   ),
          // ),
        ],
        //The reordering works perfectly...You just need to hold the tile down before moving
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var getReplacedWidget = items.removeAt(oldIndex);
            items.insert(newIndex, getReplacedWidget);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Moyin will be fine");
          //Put a function to show a dialog widget here
          //Hint
          // showDialog();
          // set the showDialog function to a variable to receive user input
        },
        tooltip: 'New ToDo',
        child: Icon(Icons.add),
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
  //REDUNDANT CODE
  // Widget checkWidget() {
  //   if (
  //       // This below is redundant
  //       // checked == false
  //       //Do it like this
  //       !checked) {
  //     return Text(
  //       widget.todoText,
  //       style: TextStyle(
  //
  //           ),
  //     );
  //   } else {
  //     return Text(
  //       widget.todoText,
  //       style: TextStyle(
  //         decoration: TextDecoration.lineThrough,
  //
  //       ),
  //     );
  //   }
  // }

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
                  });
                })
          ],
        ),
      ),
    );
  }
}
