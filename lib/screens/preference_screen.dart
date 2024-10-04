import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/Providers/preferences.dart';

class PreferenceScreen extends StatefulWidget {
  PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String sorting = 'Select Sorting Order';

  List<DropdownMenuItem> getDropDownOptions() {
    List<String> options = [
      'Select Sorting Order',
      'Due Date',
      'Task Status',
      'Priority',
      'Creation Date'
    ];
    List<DropdownMenuItem> optionItems = [];
    for (String str in options) {
      optionItems.add(
        DropdownMenuItem(
          value: str,
          child: Text(
            str,
            style: TextStyle(
              color: str == 'Select Sorting Order'
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
      body: Consumer<Preference>(builder: (context, preferences, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Light Mode',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: SwitchListTile(
                      value: preferences.isDarkTheme,
                      onChanged: (value) {
                        preferences.toggleTheme(value);
                      },
                    ),
                  ),
                  const Expanded(
                      child: Text(
                    'Dark Mode',
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: DropdownButtonFormField(
                value: preferences.sortingOrder,
                style: Theme.of(context).textTheme.labelSmall,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).iconTheme.color,
                ),
                items: getDropDownOptions(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    if (newValue != 'Select Sorting Order') {
                      setState(() {
                        sorting = newValue;
                      });
                    } else {
                      setState(() {
                        sorting = 'Due Date';
                      });
                    }
                  });
                  preferences.setNewSortingOrder(sorting);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
