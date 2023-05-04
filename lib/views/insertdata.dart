import 'package:flutter/material.dart';
import 'package:interview_practice/database/sqlite-service.dart';
import 'package:get/get.dart';
import 'package:interview_practice/main.dart';

class Insertdata extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Insert Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tasks",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Task Name",
                      hintText: "Enter Task Name"),
                ),
                ElevatedButton(
                    onPressed: () {
                      SqlDatabaseService databaseService = SqlDatabaseService();
                      databaseService.createItem(namecontroller.text);
                      Get.off(() => const FirstScreen());
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
