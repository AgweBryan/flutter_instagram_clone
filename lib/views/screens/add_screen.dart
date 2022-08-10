import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/add_post_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final AddPostController _addPostController = Get.put(AddPostController());

  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _addPostController.imagePost.isEmpty
        ? Center(
            child: IconButton(
              onPressed: () => _showOptionsDialog(context),
              color: purpleColor,
              icon: const Icon(
                Icons.file_upload_rounded,
              ),
            ),
          )
        : Scaffold(
            appBar: _appBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _addPostController.isLoading
                      ? const LinearProgressIndicator(
                          backgroundColor: purpleColor,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      authController.isCached.value
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                  authController.currentUserProfilePhoto.value),
                            )
                          : CircleAvatar(
                              backgroundImage: MemoryImage(
                                authController.currentUserProfilePhoto.value,
                              ),
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: TextField(
                          controller: _captionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    MemoryImage(_addPostController.imagePost),
                                fit: BoxFit.cover,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
  }

  _appBar() {
    return AppBar(
      backgroundColor: mobileBackgroundColor,
      leading: IconButton(
        onPressed: () =>
            _addPostController.updateSelectedImagePost(Uint8List(0)),
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: const Text(
        'Post to',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_captionController.text != '') {
              _addPostController.uploadPost(
                caption: _captionController.text,
                imagePost: _addPostController.imagePost,
                username: authController.username.value,
                profilePhoto: authController.currentUserProfilePhoto.value,
              );
            } else {
              Get.snackbar('Required', 'Please enter a caption for this post');
            }
          },
          child: const Text(
            'Post',
            style: TextStyle(
              color: Colors.purpleAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  _showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(children: const [
              Icon(Icons.image),
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  'Galley',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(children: const [
              Icon(Icons.camera),
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(children: const [
              Icon(Icons.cancel),
              Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  pickVideo(ImageSource src, BuildContext context) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: src);

    if (image != null) {
      // Update images
      _addPostController.updateSelectedImagePost(await image.readAsBytes());
    }
  }
}
