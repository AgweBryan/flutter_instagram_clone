import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';

class WebsiteScreenLayout extends StatelessWidget {
  const WebsiteScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: authController.signOut(),
        child: const Text('sign out from web'),
      ),
    );
  }
}
