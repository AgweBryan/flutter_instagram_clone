import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:flutter_instagram_clone/views/screens/auth/login_screen.dart';
import 'package:flutter_instagram_clone/views/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;

import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static final AuthController instance = Get.find();

  late Rx<User?> _user;

  final Rx<Uint8List> _selectedImage = Rx<Uint8List>((Uint8List(0)));

  Uint8List get selectedImage => _selectedImage.value;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      await image.readAsBytes().then((value) => _selectedImage.value = value);
    }
  }

  // register the user
  void registerUser(
      String username, String email, String password, Uint8List? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // Save our user to our auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await _uploadToStorage(image);

        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );

        // Insert created user to users collection
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //upload to firebase storage and get download url
  Future<String> _uploadToStorage(Uint8List image) async {
    String downloadUrl = '';

    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(authController.user.uid);

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.snackbar('Sign In', 'You have signed in successfully');
      } else {
        Get.snackbar('Error Logging In', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error Logging In', e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
