import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_practice/controller/api_controller.dart';
import 'package:interview_practice/controller/recordcontroller.dart';
import 'package:interview_practice/database/sqlite-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final recordcontroller = Get.put(Recordcontroller());
  SqlDatabaseService databaseService = SqlDatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget tasks() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: recordcontroller.tasklist.length,
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Text(
                          recordcontroller.tasklist[index]["id"].toString()),
                      title: Text(recordcontroller.tasklist[index]["taskname"]
                          .toString()),
                      onTap: () {
                        Get.bottomSheet(Container(
                          height: 150,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(recordcontroller.tasklist[index]["id"]
                                  .toString()),
                              ElevatedButton(
                                  onPressed: () {
                                    recordcontroller.delete(
                                        recordcontroller.tasklist[index]["id"]);
                                    Get.back();
                                  },
                                  child: const Text("Delete")),
                            ],
                          ),
                        ));
                      },
                    ),
                  );
                })),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(margin: EdgeInsets.all(8), elevation: 5, child: tasks()),
    );
  }
}
