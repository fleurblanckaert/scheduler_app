import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler_app/app/data/models/task.dart';
import 'package:scheduler_app/app/modules/home/controller.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/services/notification.services.dart';
import 'package:scheduler_app/app/services/theme.services.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:scheduler_app/app/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// The Notification Helper for the App
  late NotifyHelper notifyHelper;

  final HomeController _homeController = Get.put(HomeController());

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _homeController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: Column(
        children: [
          _createTaskBar(),
          _createDateBar(),
          const SizedBox(height: 15,),
          _createTaskList(),
        ],
      ),

    );
  } 

  /// Creates the Home Page App Bar
  _createAppBar() {

    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          // notifyHelper.displayNotification(
          //   title: "Theme Changed", 
          //   body: !Get.isDarkMode ? "Activated Dark Theme" : "Activated Light Theme"
          // );

          // notifyHelper.scheduledNotification();
        },
        child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round, 
            size: 20,
            color:Colors.white,
          ),
      ),
      actions: const [
        Icon(
          Icons.calendar_today,
          size: 20,
        ),
        SizedBox(width: 20,),
      ],
    );
  }

  /// Creates the Home Page Task Bar
  _createTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle(),
                ),
                Text(
                  "Today",
                  style: headingStyle(),
                ),
              ],
            ),
          ),
          AppButton(label: "+ Add Task", onTap: () async {
              await Get.toNamed(Routes.ADD_TASK);
              _homeController.getTasks();
            }
          ),
        ],
      ),
    );
  }

  /// Creates the Home Page Date Bar
  _createDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primary,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w600,
            color: secondary,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 12, 
            fontWeight: FontWeight.w600,
            color: secondary,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      )
    );
  }

  _createTaskList() {
    print('Creating task list...');
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _homeController.taskList.length,
          itemBuilder: (_, index){

            Task task = _homeController.taskList[index];

            // Check if the date matches the day selected on the date picker
            if (task.date==DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                position: index, 
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          
          }
        );
      }),
    );
  }

  /// Technically a Page, brings up Bottom Sheet for Task Options
  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1 ? 
          MediaQuery.of(context).size.height*0.40:
          MediaQuery.of(context).size.height*0.48,
        color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300] 
              ),
            ),
            // const Spacer(),
            task.isCompleted == 1 ? Container() 
            : _bottomSheetButton(
              label: "Task Completed",
              onTap: () {
                _homeController.markTaskCompleted(task.id!);
                Get.back();
              },
              color: primary,
              context: context
            ),
            const SizedBox(height: 20,),
            _bottomSheetButton(
              label: "View Task",
              onTap: () {
                Get.toNamed(Routes.VIEW_TASK);
              },
              isClose: false,
              color: secondary,
              context: context
            ),
            const SizedBox(height: 20,),
            _bottomSheetButton(
              label: "Delete",
              onTap: () {
                _homeController.deleteTask(task);
                Get.back();
              },
              color: Colors.red[300]!,
              context: context
            ),
            const SizedBox(height: 20,),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              isClose: true,
              context: context
            ),
          ],
        ),
      )
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    Color? color,
    bool isClose = false,
    required BuildContext context
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Get.isDarkMode ? Colors.grey[600]! : Colors.black : color!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Get.isDarkMode ? Colors.grey[600] : Colors.white : color,
        ),
        child: Center(child: 
          Text(
            label,
            style: isClose ? titleStyle() : titleStyle().copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
