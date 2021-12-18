import 'package:intl/intl.dart';
import 'package:scheduler_app/app/data/models/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource<Task> {
  TaskDataSource(List<Task> appointments) {
    this.appointments = appointments;
  }

  Task getTask(int index) => appointments![index] as Task;

  @override
  DateTime getStartTime(int index) {
    return DateFormat.yMd().parse(getTask(index).date!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateFormat.yMd().parse(getTask(index).date!);
  }

  @override
  String getSubject(int index) {
    return getTask(index).title!;
  }
  
}