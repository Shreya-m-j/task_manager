import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  String taskName;
  String taskDesc;
  bool taskStatus;
  String creationDate;
  String dueDate;
  String priority;
  dynamic toggleTask;
  dynamic deleteTask;
  dynamic editTask;
  DateTime creation = DateTime.now();
  DateTime due = DateTime.now();

  TaskTile(
      {required this.taskName,
      required this.taskDesc,
      required this.taskStatus,
      required this.creationDate,
      required this.dueDate,
      required this.priority,
      required this.toggleTask,
      required this.deleteTask,
      required this.editTask}) {
    creation = DateTime.parse(creationDate);
    due = DateTime.parse(dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: editTask,
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Checkbox(
                      value: taskStatus,
                      onChanged: toggleTask,
                      activeColor: Theme.of(context)
                          .checkboxTheme
                          .fillColor
                          ?.resolve({WidgetState.selected}),
                      checkColor: Theme.of(context)
                          .checkboxTheme
                          .checkColor
                          ?.resolve({WidgetState.selected}),
                    ),
                  ],
                ),
                Text(
                  taskDesc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Created on : ${DateFormat('dd/MM/yyyy').format(creation)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Due by : ${DateFormat('dd/MM/yyyy').format(due)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Priority : $priority',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                IconButton(
                  onPressed: deleteTask,
                  icon: const Icon(Icons.delete_outlined),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
