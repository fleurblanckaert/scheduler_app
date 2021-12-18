import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/data/models/task_data_source.dart';
import 'package:scheduler_app/app/modules/home/controller.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {

  const CalendarPage({ Key? key }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Should have just had a TaskController
  final HomeController _calendarController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    _calendarController.getTasks();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: TaskDataSource(_calendarController.taskList),
        initialSelectedDate: DateTime.now(),
        cellBorderColor: primary,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primary,
        onPressed: () {
            Get.toNamed(Routes.ADD_TASK);
            _calendarController.getTasks();
          },
      ),
    );
  }

   _createAppBar() {

    return AppBar(
      title: Text("View your Tasks on The Calendar", style: appBarTitleStyle(),),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
            Icons.chevron_left_outlined, 
            size: 20,
            color: Colors.white,
          ),
      ),
    );
  }
}