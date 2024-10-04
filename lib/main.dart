import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/screens/task_list_screen.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/theme.dart';
import 'package:task_manager/Providers/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(create: (context) => TaskProvider()),
        ChangeNotifierProvider<Preference>(create: (context) => Preference()),
      ],
      child: Consumer<Preference>(builder: (context, preference, child) {
        return MaterialApp(
          theme: customLightTheme,
          darkTheme: customDarkTheme,
          themeMode: preference.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            appBar: kAppBar,
            body: TaskListScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
