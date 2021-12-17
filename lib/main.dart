import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    theme:  appDarkThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
