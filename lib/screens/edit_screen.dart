import 'package:flutter/material.dart';
import 'package:task_manager/constants.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/preferences.dart';

class EditScreen extends StatefulWidget {
  int id;
  String taskName;
  String taskDesc;
  bool taskStatus;
  DateTime creationDate;
  DateTime dueDate;
  String priority;

  String taskTitle = '';
  String taskDescription = '';
  String showDate = '';

  EditScreen(
      {required this.id,
      required this.taskName,
      required this.taskDesc,
      required this.taskStatus,
      required this.creationDate,
      required this.dueDate,
      required this.priority}) {
    taskTitle = taskName;
    taskDescription = taskDesc;
    showDate = DateFormat('dd/MM/yyyy').format(dueDate);
  }

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    titleFocusNode.addListener(() {
      if (titleFocusNode.hasFocus) {
        setState(() {
          widget.taskTitle = 'Task Title';
        });
      } else {
        setState(() {
          widget.taskTitle = widget.taskName; // Reset when focus is lost
        });
      }
    });

    descFocusNode.addListener(() {
      if (descFocusNode.hasFocus) {
        setState(() {
          widget.taskDescription = 'Task Description';
        });
      } else {
        setState(() {
          widget.taskDescription = widget.taskDesc;
        });
      }
    });
  }

  void selectDueDate(BuildContext context) async {
    DateTime? pickedDueDate = await showDatePicker(
      context: context,
      initialDate: widget.dueDate.isBefore(DateTime.now())? DateTime.now() : widget.dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDueDate != null) {
      widget.dueDate = pickedDueDate;
      setState(() {
        widget.showDate = DateFormat('dd/MM/yyyy').format(widget.dueDate);
      });
    }
  }

  List<DropdownMenuItem> getDropDownOptions() {
    List<String> options = ['Select Priority', 'low', 'medium', 'high'];
    List<DropdownMenuItem> optionItems = [];
    for (String str in options) {
      optionItems.add(
        DropdownMenuItem(
          value: str,
          child: Text(
            str,
            style: TextStyle(
              color: str == 'Select Priority' ? Theme.of(context).textTheme.labelLarge?.color : Theme.of(context).textTheme.labelSmall?.color,
            ),
          ),
        ),
      );
    }
    return optionItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Edit Task',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: widget.taskTitle,
                ),
                focusNode: titleFocusNode,
                onChanged: (String newTitle) {
                  setState(() {
                    widget.taskName = newTitle;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: widget.taskDescription,
                ),
                focusNode: descFocusNode,
                onChanged: (String newDesc) {
                  setState(() {
                    widget.taskDesc = newDesc;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: DropdownButtonFormField(
                value: widget.priority,
                style: Theme.of(context).textTheme.labelSmall,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).iconTheme.color,
                ),
                items: getDropDownOptions(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    widget.priority = newValue;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  selectDueDate(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.showDate,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Material(
                elevation: 2.0,
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 4.0, 5.0, 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Task Status',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Checkbox(
                        value: widget.taskStatus,
                        onChanged: (value) {
                          setState(() {
                            widget.taskStatus = !widget.taskStatus;
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: kContrastColorLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final editedTask = Task(
                          id: widget.id,
                          taskName: widget.taskName,
                          taskDesc: widget.taskDesc,
                          taskStatus: widget.taskStatus,
                          creationDate: (widget.creationDate).toString(),
                          dueDate: widget.dueDate.toIso8601String(),
                          priority: widget.priority,
                        );
                        await Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(editedTask,Provider.of<Preference>(context, listen: false).sortingOrder);
                        // await Provider.of<TaskProvider>(context, listen: false)
                        //     .displayAllTasksOnConsole();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
