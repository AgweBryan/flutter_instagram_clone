import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/favorites_controller.dart';
import 'package:flutter_instagram_clone/controllers/posts_controller.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PostsController());
    Get.put(FavoritesController());
    if (kIsWeb) {
      // Web screen
      return webScreenLayout(context);
    } else {
      // Mobile screen
      return const MobileScreenLayout();
    }
  }

// Did this here because of some error i couldn't fix
  Widget webScreenLayout(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () => authController.signOut(),
        child: const Text('Sign out from web oo'),
      )),
    );
  }
}
