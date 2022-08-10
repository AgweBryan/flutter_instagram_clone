import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_instagram_clone/controllers/auth_controller.dart';
import 'package:flutter_instagram_clone/controllers/theme_controller.dart';
import 'package:flutter_instagram_clone/views/screens/add_screen.dart';
import 'package:flutter_instagram_clone/views/screens/favorites_screen.dart';
import 'package:flutter_instagram_clone/views/screens/home_screen.dart';
import 'package:flutter_instagram_clone/views/screens/profile_screen.dart';
import 'package:flutter_instagram_clone/views/screens/search_screen.dart';

// CONTROLLERS
final authController = AuthController.instance;
final themeController = ThemeController.instance;

// FIREBASE
final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

// PAGES
final List<Widget> pages = [
  HomeScreen(),
  SearchScreen(),
  AddScreen(),
  FavoritesScreen(),
  ProfileScreen(),
];

// OTHERS
final DefaultCacheManager defaultCacheManager = DefaultCacheManager();
