import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskName TEXT,
        taskDesc TEXT,
        taskStatus INTEGER,
        creationDate TEXT,
        dueDate TEXT,
        priority TEXT
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  //getting tasks based on sorting order
  Future<List<Task>> getTasks(String sortingOrder) async {

    String query;
    if(sortingOrder=='Due Date'){
      query = 'dueDate ASC, taskStatus ASC';
    }else if(sortingOrder=='Task Status'){
      query = '''taskStatus ASC, dueDate ASC,CASE priority
      WHEN 'low' THEN 3
      WHEN 'medium' THEN 2
      WHEN 'high' THEN 1
      END ASC''';
    }else if(sortingOrder=='Priority'){
      query = '''
      CASE priority
        WHEN 'low' THEN 3
        WHEN 'medium' THEN 2
        WHEN 'high' THEN 1
        ELSE 4
      END ASC,
      taskStatus ASC, 
      dueDate ASC
    ''';
    }else if(sortingOrder=='Creation Date'){
      query = 'creationDate ASC';
    }else{
      query= 'creationDate ASC';
    }

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks',orderBy: query);
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    if (task.id == null) {
      throw Exception("Task ID cannot be null for updating.");
    }
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> toggleTask(int id, bool value) async {
    final db = await database;
    return await db.update(
      'tasks',
      {'taskStatus' : value == true ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    printAllTasks();
  }

  //console printing for debugging
  Future<void> printAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query('tasks');
    tasks.forEach((task) {
      print(task);
    });
  }
}
