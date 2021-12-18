class Task {

  /// database id 
  int? id; 
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['date'] = date;

    return data;
  }

}