import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPostController extends GetxController {
  final Rx<Uint8List> _imagePost = Uint8List(0).obs;
  final Rx<bool> _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  Uint8List get imagePost => _imagePost.value;

  updateSelectedImagePost(Uint8List image) => _imagePost.value = image;

  uploadPost({
    required String caption,
    required Uint8List imagePost,
    required String username,
    required String profilePhoto,
  }) async {
    _isLoading.value = true;
    try {
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .get();

      final allDocs = await firestore.collection('posts').get();

      int len = allDocs.docs.length;
      final String id = 'Post $len';

      String postUrl = await _uploadPostToStorage(id, imagePost);

      Post post = Post(
        id: id,
        caption: caption.trim(),
        commentCount: 0,
        likes: [],
        datePublished: DateFormat.yMMMd().format(DateTime.now()),
        postUrl: postUrl,
        // profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
        profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
        reports: [],
        shareCount: [],
        uid: authController.user.uid,
        username: username,
      );

      await firestore.collection('posts').doc(id).set(post.toJson());
      _isLoading.value = false;
      Get.snackbar('Success!', 'Posted successfully');
      _imagePost.value = Uint8List(0);
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar('Upload error', e.toString());
    }
  }

  _uploadPostToStorage(String postId, Uint8List postUrl) async {
    Reference ref = firebaseStorage.ref().child('posts').child(postId);
    UploadTask uploadTask = ref.putData(postUrl);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
