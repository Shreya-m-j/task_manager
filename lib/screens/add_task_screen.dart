import 'package:flutter/material.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Providers/preferences.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime dueDate = DateTime.now();
  DateTime creationDate = DateTime.now();
  String priority = 'Select Priority';
  String showDate = 'Select Due Date';

  void selectDueDate(BuildContext context) async {
    DateTime? pickedDueDate = await showDatePicker(
      context: context,
      initialDate: creationDate,
      firstDate: creationDate,
      lastDate: DateTime(2030),
    );
    if (pickedDueDate != null) {
      dueDate = pickedDueDate;
      setState(() {
        showDate = DateFormat('dd/MM/yyyy').format(dueDate);
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
              color: str == 'Select Priority'
                  ? Theme.of(context).textTheme.labelLarge?.color
                  : Theme.of(context).textTheme.labelSmall?.color,
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
                'Add a New Task',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Enter Task Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Enter Task Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: DropdownButtonFormField(
                value: priority,
                style: Theme.of(context).textTheme.labelSmall,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).iconTheme.color,
                ),
                items: getDropDownOptions(),
                onChanged: (dynamic newValue) {
                  if (newValue != 'Select Priority') {
                    setState(() {
                      priority = newValue;
                    });
                  } else {
                    setState(() {
                      priority = 'low';
                    });
                  }
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
                      showDate,
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final newTask = Task(
                          taskName: titleController.text,
                          taskDesc: descriptionController.text,
                          creationDate: creationDate.toIso8601String(),
                          dueDate: dueDate.toIso8601String(),
                          priority: priority,
                        );
                        await Provider.of<TaskProvider>(context, listen: false).addTask(newTask, Provider.of<Preference>(context, listen: false).sortingOrder);
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
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
