import 'package:flutter/material.dart';
import 'package:task_manager/constants.dart';

final ThemeData customLightTheme = ThemeData(
  scaffoldBackgroundColor: kBodyColorLight,
  brightness: Brightness.light,
  cardColor: kContainerColorLight,

  //General Color Scheme
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: kBodyColorLight,
    surface: kContainerColorLight,
    secondary: kContrastColorLight,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),

  //Appbar theme
  appBarTheme: const AppBarTheme(
    color: kContrastColorLight,
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  //Text theme
  textTheme: const TextTheme(
    //used for 'All tasks' kind of texts (title of a page) and 'Add new task'
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
    ),
    //used for Task Name
    bodyMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    //for everything else within card like desc, dates, etc
    bodySmall: TextStyle(
      fontSize: 15.0,
    ),
    //drop down items
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: Colors.black45,
    ),
    //for cancel and save buttons
    titleMedium: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),

  //Add new Task button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kContrastColorLight,
    foregroundColor: Colors.white,
    elevation: 5.0,
  ),

  //elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style : ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorLight),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(2.0),
    ),
  ),

  //Text field + drop down
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kContainerColorLight,
    labelStyle: const TextStyle(
      color: Colors.black87,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: kContrastColorLight,
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: kContrastColorLight,
        width: 2.0,
      ),
    ),
  ),

  //Date Picker Calendar theme
  datePickerTheme: DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorLight),
      foregroundColor: WidgetStateProperty.all(Colors.white), // Change button text color to white
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorLight),
      foregroundColor: WidgetStateProperty.all(Colors.white), // Change button text color to white
    ),
  ),

  //check box decoration
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return kContrastColorLight; // Fill color when checked
        }
        return kBodyColorLight; // Fill color when unchecked
      },
    ),
  ),

  //Icon color
  iconTheme: const IconThemeData(
    color: Colors.black87,
  ),

  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStateProperty.all(kContrastColorLight),
    thumbColor: WidgetStateProperty.all(Colors.black45),
  ),

);




final ThemeData customDarkTheme = ThemeData(
  scaffoldBackgroundColor: kBodyColorDark,
  brightness: Brightness.dark,
  cardColor: kContainerColorDark,

  //General Color Scheme
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: kBodyColorDark,
    surface: kContainerColorDark,
    secondary: kContrastColorDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),

  //Appbar theme
  appBarTheme: const AppBarTheme(
    color: kContrastColorDark,
    titleTextStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  //Text theme
  textTheme: const TextTheme(
    //used for 'All tasks' kind of texts (title of a page) and 'Add new task'
    titleLarge: TextStyle(
      color: Color(0xffEEEEEE),
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
    ),
    //used for Task Name
    bodyMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Color(0xffEEEEEE),
    ),
    //for everything else within card like desc, dates, etc
    bodySmall: TextStyle(
      fontSize: 15.0,
      color: Color(0xffEEEEEE),
    ),
    //drop down items
    labelSmall: TextStyle(
      color: Color(0xffEEEEEE),
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: Color(0xffa7a7a7),
    ),
    //for cancel and save buttons
    titleMedium: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),

  //Add new Task button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kContrastColorDark,
    foregroundColor: Colors.white,
    elevation: 5.0,
  ),

  //elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style : ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorDark),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(2.0),
    ),
  ),

  //Text field + drop down
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kContainerColorDark,
    labelStyle: const TextStyle(
      color: Colors.white54,
      // color: Color(0xffEEEEEE),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: kContrastColorDark,
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: kContrastColorDark,
        width: 2.0,
      ),
    ),
  ),

  //Date Picker Calendar theme
  datePickerTheme: DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorDark),
      foregroundColor: WidgetStateProperty.all(Colors.white), // Change button text color to white
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(kContrastColorDark),
      foregroundColor: WidgetStateProperty.all(Colors.white), // Change button text color to white
    ),
  ),

  //Check box theme
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return kContrastColorDark; // Fill color when checked
        }
        return kBodyColorDark; // Fill color when unchecked
      },
    ),
  ),

  //ICON color
  iconTheme: const IconThemeData(
    color: Color(0xffa7a7a7),
  ),

  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStateProperty.all(kContrastColorDark),
    thumbColor: WidgetStateProperty.all(Colors.white70),
  ),

);