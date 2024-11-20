import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),

    );

  }
}
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
  // TextEditingController _date= TextEditingController();
}
class _TodoListScreenState extends State<TodoListScreen> {
  TextEditingController _date=TextEditingController();
  List<String> _todos = [];
  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = "";
        String date = "";
        String ID = "";
        _date.text=date;
        // _date.text=date;
        return AlertDialog(
          title: Text("Add a new To-Do"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.supervised_user_circle),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                readOnly: true,
                controller: _date,
                decoration: InputDecoration(
                  labelText: "Date",
                  prefixIcon: Icon(Icons.date_range),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      _date.text = date;
                    });
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "ID Number",
                  prefixIcon: Icon(Icons.perm_identity),
                ),
                onChanged: (value) {
                  ID= value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (name.isNotEmpty || date.isNotEmpty ||ID.isNotEmpty) {
                    _todos.add("Name: $name\nDate: $date\nTime: $ID");
                  }
                  Navigator.pop(context);
                });
              },
              child: Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aesthetic To-Do List"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index)
        {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                _todos[index],
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  setState((){
                    _todos.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
