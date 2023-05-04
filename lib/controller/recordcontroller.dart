import 'package:get/get.dart';
import 'package:interview_practice/database/sqlite-service.dart';

class Recordcontroller extends GetxController {
  var tasklist = <Map<String, dynamic>>[].obs;
  SqlDatabaseService databaseService = SqlDatabaseService();

  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  getdata() async {
    List<Map<String, dynamic>> tasks = [];
    tasks = await databaseService.getItems();
    tasklist.assignAll(tasks);
    update();
  }

  delete(int id) {
    databaseService.delete(id);
    getdata();
  }
}
