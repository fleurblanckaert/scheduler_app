import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Provides methods for utilizing notifications in the application.
class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); 

  initializeNotification() async {
    tz.initializeTimeZones();
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification
    );

  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to Flutter!"));
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    } else {
      print('Notification Done!');
    }

    Get.to(() => Container(color: Colors.white));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  displayNotification({required String title, required String body}) async {
    print("$title $body");

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'scheduler_app', 
      'channel_name', 
      channelDescription: 'scheduling',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, 
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  scheduledNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, 
      'scheduled title', 
      'scheduled body 5 seconds ago', 
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), 
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduler_app', 
          'channel_name',
          channelDescription: 'Description'
        ),
      ), 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true
      );
  }
}