import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  GoogleSignInAccount? _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  setdatainpreferences() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (_userObj!.displayName != null && _userObj!.email.isNotEmpty) {
      sp.setString("email", _userObj!.email.toString());
      sp.setString("name", _userObj!.displayName.toString());
    } else {
      print("Null");
    }
  }

  getdata() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("name");
    sp.getString("email");
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              onPressed: () {
                _googleSignIn.signIn().then((value) async {
                  setState(() {
                    print(value.toString());
                    _userObj = value;
                  });
                  final SharedPreferences sp =
                      await SharedPreferences.getInstance();
                  sp.setString("email", _userObj!.email.toString());
                  sp.setString("name", _userObj!.displayName.toString());
                });
              },
              child: const Text("Log in"))
        ],
      ),
    );
  }
}
