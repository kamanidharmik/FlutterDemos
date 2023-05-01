import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_practice/controller/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpreferencedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(120),
        elevation: 5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(email),
            ],
          ),
        ),
      ),
    );
  }
}
