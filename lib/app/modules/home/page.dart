import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/services/notification.services.dart';
import 'package:scheduler_app/app/services/theme.services.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// The Notification Helper for the App
  late NotifyHelper notifyHelper;

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
        children: const [
          Text("Theme Data", 
            style: TextStyle(
              fontSize: 30 
            )),
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
        notifyHelper.displayNotification(
          title: "Theme Changed", 
          body: !Get.isDarkMode ? "Activated Dark Theme" : "Activated Light Theme"
        );

        notifyHelper.scheduledNotification();
      },
      child: const Icon(
          Icons.nightlight_round, 
          size: 20,
        ),
    ),
    actions: const [
      Icon(
        Icons.settings,
        size: 20,
      ),
      SizedBox(width: 20,),
    ],
  );
}
}
