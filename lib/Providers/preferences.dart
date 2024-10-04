import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference extends ChangeNotifier {

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  String _sortingOrder = 'Task Status';
  String get sortingOrder => _sortingOrder;

  Preference() {
    loadThemeFromPreferences();
  }

  void loadThemeFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
    _sortingOrder = preferences.getString('sortingOrder') ?? 'Due Date';
    notifyListeners();
  }

  Future<void> saveThemeToPreferences(bool isDarkTheme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDarkTheme', isDarkTheme);
  }

  Future<void> saveSortingToPreferences(String sortingOrder) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sortingOrder', sortingOrder);
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkTheme = value;
    await saveThemeToPreferences(_isDarkTheme);
    notifyListeners();
  }

  Future<void> setNewSortingOrder(String sortingOrder) async {
    _sortingOrder = sortingOrder;
    await saveSortingToPreferences(_sortingOrder);
    notifyListeners();
  }

}
