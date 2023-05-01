// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Screen extends StatelessWidget {
  GoogleSignInAccount? _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  setdatainpreferences() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (_userObj!.displayName != null && _userObj!.email.isNotEmpty) {
      sp.setString("email", _userObj!.email.toString());
      sp.setString("name", _userObj!.displayName.toString());
    } else {
      sp.setString("name", "Kamani Dharmik");
      sp.setString("email", "dharmikkamani12@gmail.com");
      print("Null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final SharedPreferences sp =
                    await SharedPreferences.getInstance();
                sp.setString("name", "Kamani Dharmik");
                sp.setString("email", "dharmikkamani12@gmail.com");

                _googleSignIn.signIn().then((value) async {
                  _userObj = value;

                  // sp.setString("email", _userObj!.email.toString());
                  // sp.setString("name", _userObj!.displayName.toString());
                });
              },
              child: const Text("Log in"))
        ],
      ),
    );
  }
}
