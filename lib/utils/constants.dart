import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram_clone/controllers/auth_controller.dart';
import 'package:flutter_instagram_clone/controllers/theme_controller.dart';

// CONTROLLERS
final authController = AuthController.instance;
final themeController = ThemeController.instance;

// FIREBASE
final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;
