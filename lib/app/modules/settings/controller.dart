import 'package:get/get.dart';
import 'package:scheduler_app/app/data/providers/db_provider.dart';

class SettingsController extends GetxController {

  @override
  void onReady() {
    super.onReady();
  }

  Future<int> deleteAllData() async {
    return await DBProvider.deleteAllData();
  }
  
}