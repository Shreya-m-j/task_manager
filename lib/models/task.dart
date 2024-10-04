class Task{

  int? id;
  String taskName;
  String taskDesc;
  bool taskStatus;
  String creationDate;
  String dueDate;
  String priority;

  Task({this.id, required this.taskName,required this.taskDesc, this.taskStatus=false, required this.creationDate, required this.dueDate, this.priority='low'});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDesc': taskDesc,
      'taskStatus': taskStatus ? 1 : 0,
      'creationDate': creationDate,
      'dueDate': dueDate,
      'priority':priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['taskName'],
      taskDesc: map['taskDesc'],
      taskStatus: map['taskStatus'] == 1,
      creationDate: map['creationDate'],
      dueDate: map['dueDate'],
      priority: map['priority'],
    );
  }

  void toggleTask(){
    taskStatus = !taskStatus;
  }
}