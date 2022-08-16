import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/profile_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'username',
        ),
      ),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
