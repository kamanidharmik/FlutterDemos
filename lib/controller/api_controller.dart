import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Apidata extends GetxController {
  late Map mapresponse;
  List data = [];

  @override
  void onInit() async {
    super.onInit();
    getdatafrominternet();
  }

  getdatafrominternet() async {
    final response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=20"));
    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);
      data = mapresponse['results'];
      print("Response Data ${data.toString()}");
    } else {
      throw Exception("Data No Found");
    }
    update();
  }
}
