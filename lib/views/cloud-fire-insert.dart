import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InserttoFirebase extends StatefulWidget {
  const InserttoFirebase({super.key});

  @override
  State<InserttoFirebase> createState() => _InserttoFirebaseState();
}

class _InserttoFirebaseState extends State<InserttoFirebase> {
  final key = GlobalKey<FormState>();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  validate() {
    if (key.currentState!.validate()) {
      final db = FirebaseFirestore.instance.collection("name");

      if (datecontroller.text.isEmpty) {
        print("Please enter a date");
      } else {
        final data = <String, dynamic>{
          "id": idcontroller.text,
          "task": taskcontroller.text,
          "date": datecontroller.text,
        };
        db.add(data);
        idcontroller.text = "";
        taskcontroller.text = "";
        datecontroller.text = "";
      }
    } else {
      print("Invalid state");
    }
  }

  showdatepicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    String formattedDate =
        "${pickedDate!.day.toString()}/${pickedDate.month.toString()}/${pickedDate.year.toString()}";
    print(formattedDate);
    datecontroller.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Store Data To Firebase",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: idcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Id"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a value";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: taskcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Task"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a value";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      showdatepicker();
                    },
                    child: const Text("Pick Date")),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      validate();
                    },
                    child: const Text("Submit"))
              ],
            ),
          )),
    );
  }
}
