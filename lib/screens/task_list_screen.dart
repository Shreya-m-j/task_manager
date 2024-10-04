import 'package:flutter/material.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/screens/edit_screen.dart';
import 'package:task_manager/screens/preference_screen.dart';
import 'package:task_manager/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/preferences.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String sortingOrder = Provider.of<Preference>(context).sortingOrder;
    Provider.of<TaskProvider>(context, listen: false).loadTasks(sortingOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(3.0,3.0,3.0,10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(
                      labelText: 'Search for a task',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        color: Theme.of(context).iconTheme.color,
                        onPressed: () {
                          setState(() {
                            queryController.clear();
                          });
                          Provider.of<TaskProvider>(context, listen: false)
                              .searchTasks('');
                        },
                      ),
                    ),
                    onChanged: (query) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .searchTasks(query);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.list,
                      size: 35.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreferenceScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    int? id = taskProvider.filteredTasks[index].id;
                    String taskName =
                        taskProvider.filteredTasks[index].taskName;
                    String taskDesc =
                        taskProvider.filteredTasks[index].taskDesc;
                    bool taskStatus =
                        taskProvider.filteredTasks[index].taskStatus;
                    String creationDate =
                        taskProvider.filteredTasks[index].creationDate;
                    String dueDate = taskProvider.filteredTasks[index].dueDate;
                    String priority =
                        taskProvider.filteredTasks[index].priority;
                    return TaskTile(
                      taskName: taskName,
                      taskDesc: taskDesc,
                      taskStatus: taskStatus,
                      creationDate: creationDate,
                      dueDate: dueDate,
                      priority: priority,
                      toggleTask: (value) async {
                        await taskProvider.toggleTaskFromClass(
                                id!,
                                value,
                                Provider.of<Preference>(context,
                                        listen: false)
                                    .sortingOrder);
                      },
                      deleteTask: () async {
                        taskProvider.deleteTask(
                            id!,
                            Provider.of<Preference>(context, listen: false)
                                .sortingOrder);
                      },
                      editTask: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditScreen(
                                id: id!,
                                taskName: taskName,
                                taskDesc: taskDesc,
                                taskStatus: taskStatus,
                                creationDate: DateTime.parse(creationDate),
                                dueDate: DateTime.parse(dueDate),
                                priority: priority,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  itemCount: taskProvider.filteredTasks.length,
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddTaskScreen();
                  },
                ),
              );
            },
            child: Text(
              'Add New Task',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
