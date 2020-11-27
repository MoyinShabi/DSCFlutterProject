import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dsc_flutter_project/todo_list_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

// List items = ["Item 1", "Item 2", "Item 3"];
// bool toggle = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple ToDos",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListScreen(),
    );
  }
}

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TODOs'),
//       ),
//       body: ReorderableListView(
//         children: [
//           for (final item in items)
//             CheckboxListTile(
//               value: toggle,
//               onChanged: (bool) {
//                 setState(() {
//                   if (!bool) {
//                     toggle = false;
//                   } else {
//                     toggle = true;
//                   }
//                 });
//               },
// key: ValueKey(item),
//               title: CheckToDo(
//                 todoText: item,
//                 todoToggle: false,
//               ),
//             ),
//         ],
// onReorder: (oldIndex, newIndex) {
//   setState(() {
//     if (oldIndex < newIndex) {
//       newIndex -= 1;
//     }
//     var getReplacedWidget = items.removeAt(oldIndex);
//     items.insert(newIndex, getReplacedWidget);
//   });
// },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: null,
//         tooltip: 'New ToDo',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class CheckToDo extends StatelessWidget {
//   final bool todoToggle;
//   final String todoText;
//   CheckToDo({this.todoToggle, this.todoText}) : super();

//   Widget checkWidget() {
//     if (todoToggle == false) {
//       return Text(todoText);
//     } else {
//       return Text(
//         todoText,
//         style: TextStyle(
//           decoration: TextDecoration.lineThrough,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return checkWidget();
//   }
// }
