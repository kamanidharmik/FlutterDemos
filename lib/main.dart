import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_practice/controller/recordcontroller.dart';
import 'package:interview_practice/database/sqlite-service.dart';
import 'package:interview_practice/views/api_screen.dart';
import 'package:interview_practice/views/insertdata.dart';
import 'package:interview_practice/views/login_screen.dart';
import 'package:interview_practice/views/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? checkname;
  getvaluefrompref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("name")) {
      setState(() {
        checkname = sharedPreferences.getString("name");
      });
    } else {
      checkname = "";
      print("No Data Found");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvaluefrompref();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkname != null ? const FirstScreen() : const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final recordcontroller = Get.put(Recordcontroller());
  int index = 0;
  String title = "Home";
  List<Widget> screens = [Data(), const Profile_Screen(), ApiDemo()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recordcontroller.getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
                if (index == 0) {
                  title = "Home";
                } else if (index == 1) {
                  title = "Profile";
                } else if (index == 2) {
                  title = "Api Demo";
                }
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
              BottomNavigationBarItem(icon: Icon(Icons.api), label: "Api Demo"),
            ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(Insertdata());
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: const Drawer(),
        body: screens[index]);
  }
}

class Data extends StatelessWidget {
  final recordcontroller = Get.put(Recordcontroller());
  SqlDatabaseService databaseService = SqlDatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return ListView.builder(
              itemCount: recordcontroller.tasklist.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading:
                        Text(recordcontroller.tasklist[index]["id"].toString()),
                    title: Text(recordcontroller.tasklist[index]["taskname"]
                        .toString()),
                    onTap: () {
                      Get.bottomSheet(Container(
                        height: 150,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Bottom Sheet"),
                            Text(recordcontroller.tasklist[index]["id"]
                                .toString()),
                            ElevatedButton(
                                onPressed: () {
                                  databaseService.delete(
                                      recordcontroller.tasklist[index]["id"]);
                                  Get.back();
                                },
                                child: const Text("Delete")),
                          ],
                        ),
                      ));
                      print(recordcontroller.tasklist[index]["id"].toString());
                    },
                  ),
                );
              }));
        }));
  }
}
