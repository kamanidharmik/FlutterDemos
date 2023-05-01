import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Hero Animation"),
      ),
      body: Hero(
        tag: 'heroanim',
        child: Image.asset(
          "assets/images/dk.JPG",
          height: 400,
          width: 300,
        ),
      ),
    );
  }
}
