import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/posts_controller.dart';
import 'package:flutter_instagram_clone/controllers/profile_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final PostsController _postsController = Get.find();

  @override
  void initState() {
    super.initState();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(controller.user['name']),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      widget.uid == authController.user.uid
                          ? ClipOval(
                              child: CachedNetworkImage(
                              imageUrl:
                                  authController.currentUserProfilePhoto.value,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ))
                          : Hero(
                              tag: widget.uid,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.user['profilePhoto'],
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildlStateColumn(
                                    controller.user['posts'].length.toString(),
                                    'posts'),
                                _buildlStateColumn(
                                    controller.user['followers'], 'followers'),
                                _buildlStateColumn(
                                    controller.user['following'], 'following'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: _followButton(
                                    text: widget.uid == authController.user.uid
                                        ? 'Sign Out'
                                        : controller.user['isFollowing']
                                            ? 'Unfollow User'
                                            : 'Follow User',
                                    backgroundColor: mobileBackgroundColor,
                                    textColor: purpleColor,
                                    borderColor: Colors.grey,
                                    onTap: () {
                                      if (widget.uid ==
                                          authController.user.uid) {
                                        authController.signOut();
                                      } else {
                                        controller.followUser();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _buildlStateColumn(String count, String label) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  _followButton(
      {required Color borderColor,
      required String text,
      required Color textColor,
      required Color backgroundColor,
      required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          height: 29,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
