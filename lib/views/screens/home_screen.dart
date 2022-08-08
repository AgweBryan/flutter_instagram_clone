import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () => authController.signOut(),
              child: const Text('Sign out!'))),
    );
  }
}
