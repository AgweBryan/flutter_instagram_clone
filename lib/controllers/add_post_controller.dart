import 'dart:typed_data';

import 'package:get/get.dart';

class AddPostController extends GetxController {
  final Rx<Uint8List> _imagePost = Uint8List(0).obs;

  Uint8List get imagePost => _imagePost.value;

  updateSelectedImagePost(Uint8List image) => _imagePost.value = image;

  uploadPost({
    required String caption,
    required Uint8List postUrl,
    required String username,
    required Uint8List profilePhoto,
  }) async {
    print(caption);
    print(postUrl);
    print(username);
    print(profilePhoto);
  }
}
