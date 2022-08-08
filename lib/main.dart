import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram_clone/controllers/auth_controller.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyAzlKRwa-05DNiUpGmYEAFm8bNaaN2-mj4",
      authDomain: "instagram-clone-87a35.firebaseapp.com",
      projectId: "instagram-clone-87a35",
      storageBucket: "instagram-clone-87a35.appspot.com",
      messagingSenderId: "398811810572",
      appId: "1:398811810572:web:ad061ce91251316ee31729",
    )).then((_) => Get.put(AuthController()));
  } else {
    await Firebase.initializeApp().then((_) => Get.put(AuthController()));
  }

  // Set screen orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(
        milliseconds: 1000,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
