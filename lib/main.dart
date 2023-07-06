import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void showTaskDetails(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Title: ${task.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Description: ${task.description}'),
              SizedBox(height: 8.0),
              Text('Deadline: ${task.deadline}'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  deleteTask(task);
                  Navigator.pop(context);
                },
                child: Text('Delete Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Task Management'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            onTap: () => showTaskDetails(context, task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String title = '';
              String description = '';
              String deadline = '';

              return AlertDialog(
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Wright Your Title',
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'Wright your Description',
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                      maxLines: 6,
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Wright your Deadline',
                        labelText: 'Deadline',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        deadline = value;
                      },
                    ),
                    SizedBox(
                      height: 10,)
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      addTask(Task(title, description, deadline));
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final String deadline;

  Task(this.title, this.description, this.deadline);
}
