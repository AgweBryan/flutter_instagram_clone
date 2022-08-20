import 'package:flutter/material.dart';

class RestartApp extends StatelessWidget {
  const RestartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Text(
            'Please restart the app to sign in again or create a new account',
            style: TextStyle(fontSize: 20),
          ))),
    );
  }
}
