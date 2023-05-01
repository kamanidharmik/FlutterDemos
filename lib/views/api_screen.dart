import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_practice/controller/api_controller.dart';

class ApiDemo extends StatelessWidget {
  ApiDemo({super.key});

  final apicontroller = Get.put(Apidata());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height,
        //   child: GetBuilder(
        //     builder: (controller) {
        //       return apicontroller.data.isEmpty
        //           ? const CircularProgressIndicator()
        //           : ListView.builder(
        //               shrinkWrap: true,
        //               itemCount: apicontroller.data.length,
        //               itemBuilder: (context, index) {
        //                 return ListTile(
        //                   leading: Image.network(
        //                       apicontroller.data[index]['picture']['medium']),
        //                   title: Text(
        //                       "${apicontroller.data[index]['name']['title'].toString()} ${apicontroller.data[index]['name']['first'].toString()} ${apicontroller.data[index]['name']['last'].toString()}"),
        //                   subtitle: Text(
        //                       apicontroller.data[index]['email'].toString()),
        //                 );
        //               },
        //             );
        //     },
        //   ),
        // ),
        Text("data")
      ],
    );
  }
}
