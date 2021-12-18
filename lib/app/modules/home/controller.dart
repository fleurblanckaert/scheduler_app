import 'package:get/get.dart';
import 'package:scheduler_app/app/data/models/task.dart';
import 'package:scheduler_app/app/data/providers/db_provider.dart';

class HomeController extends GetxController {
  
  var taskList = <Task>[].obs;

  @override
  void onReady() {
    super.onReady();
  }
  
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBProvider.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  Future<int> deleteTask(Task task) async {
    return await DBProvider.delete(task);
  }
}