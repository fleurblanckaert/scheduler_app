import 'package:get/get.dart';
import 'package:scheduler_app/app/modules/add_task/page.dart';
import 'package:scheduler_app/app/modules/home/page.dart';
import 'package:scheduler_app/app/modules/welcome/page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL, 
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: Routes.HOME, 
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.ADD_TASK,
      page: () => const AddTaskPage(),
    ),
    GetPage(
      name: Routes.VIEW_TASK,
      page: () => const AddTaskPage(),
    ),
  ];
}