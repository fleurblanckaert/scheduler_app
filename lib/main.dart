import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scheduler_app/app/data/providers/db_provider.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/services/theme.services.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider.initDb();
  await GetStorage.init();
  await Settings.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    themeMode: ThemeService().theme,
    theme:  appLightThemeData,
    darkTheme: appDarkThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
