import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:interview_practice/modals/usermodal.dart';

class Apidata extends GetxController {
  late Map mapresponse;
  List data = [];

  var isloading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getdatafrominternet();
  }

  getdatafrominternet() async {
    final response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=20"));
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body.toString());
      mapresponse = json.decode(response.body);
      data = mapresponse['results'];
      print(data.toString());
      // return UserModal.fromJson(map);
    } else {
      throw Exception("Data No Found");
    }
    update();
  }
}
