import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/services/notification.services.dart';
import 'package:scheduler_app/app/services/theme.services.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// The Notification Helper for the App
  late NotifyHelper notifyHelper;

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: Column(
        children: [
          _createTaskBar(),
          _createDateBar(),
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
          AppButton(label: "+ Add Task", onTap: () => Get.toNamed(Routes.ADD_TASK)),
        ],
      ),
    );
  }

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
          _selectedDate = date;
        },
      )
    );
  }
}
