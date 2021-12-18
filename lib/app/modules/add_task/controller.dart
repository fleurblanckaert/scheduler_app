import 'package:get/get.dart';
import 'package:scheduler_app/app/data/models/task.dart';
import 'package:scheduler_app/app/data/providers/db_provider.dart';

class TaskController extends GetxController {

  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBProvider.insert(task!);
  }

}
