import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_practice/controller/recordcontroller.dart';
import 'package:interview_practice/database/sqlite-service.dart';
import 'package:interview_practice/views/api_screen.dart';
import 'package:interview_practice/views/cloud-fire-insert.dart';
import 'package:interview_practice/views/heroanim.dart';
import 'package:interview_practice/views/insertdata.dart';
import 'package:interview_practice/views/login_screen.dart';
import 'package:interview_practice/views/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  print(analytics);
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
      home: checkname != null ? const FirstScreen() : Login_Screen(),
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
  List<Widget> screens = [const InserttoFirebase(), ProfileScreen(), ApiDemo()];

  String name = "Guest";
  String email = "guest@gmail.com";

  getpreferencedata() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("name");
    sp.getString("email");
    setState(() {
      name = sp.getString("name")!;
      email = sp.getString("email")!;
    });
  }

  clearpreferencesdata() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    recordcontroller.getdata();

    getpreferencedata();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
                  title = "Sql Lite Data";
                } else if (index == 2) {
                  title = "Api Data";
                }
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: "Sql Lite Data"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.api_outlined), label: "Api"),
            ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(Insertdata());
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.licdn.com/dms/image/D4D03AQFDhvF1A7uEPw/profile-displayphoto-shrink_800_800/0/1678513895740?e=2147483647&v=beta&t=nz6lrJbnReKkL34R_VeF5QQFWFTauRaeezoWQIoVZvI"),
                  ),
                  accountName: Text(name),
                  accountEmail: Text(email)),
              ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
                onTap: () {
                  clearpreferencesdata();
                  _googleSignIn.signOut();
                  Get.off(Login_Screen());
                },
              )
            ],
          ),
        ),
        body: screens[index]);
  }
}

class Data extends StatefulWidget {
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final recordcontroller = Get.put(Recordcontroller());

  SqlDatabaseService databaseService = SqlDatabaseService();

  BannerAd? _bannerAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadad() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print("AdFailed to load ad: $error");
          },
        ),
        request: const AdRequest())
      ..load();
  }

  initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'heroanim',
            child: Image.asset(
              "assets/images/dk.JPG",
              height: 300,
              width: 250,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const MyWidget();
                  },
                ));
              },
              child: const Text("Go To Next Screen")),
          Container(
            height: 500,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('name').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Expanded(
                          child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((e) {
                                return Container(
                                  child: Text("${e['priority']} ${e['task']}"),
                                );
                              }).toList()),
                        );
                      },
                    ),
                  );
                } else {
                  print("Data is not available");
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}
