import 'package:get/get.dart';
import 'package:scheduler_app/app/modules/home/page.dart';
import 'package:scheduler_app/app/modules/welcome/page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL, 
      page: () => HomePage(),
    ),
    // GetPage(
    //   name: Routes.HOME, 
    //   page: null
    // ),
    // GetPage(
    //   name: Routes.ADD_TASK 
    //   page: null
    // ),
  ];
}