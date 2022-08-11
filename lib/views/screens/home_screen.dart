import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/posts_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/views/widgets/post_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final PostsController _postsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() => _postsController.posts.isEmpty
          ? const Center(
              child: Text('No post yer'),
            )
          : ListView.builder(
              itemCount: _postsController.posts.length,
              itemBuilder: (context, i) {
                final post = _postsController.posts[i];
                return PostCard(post: post);
              },
            )),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: mobileBackgroundColor,
      title: const Text(
        'Instagram',
        style: TextStyle(
            fontSize: 35, color: purpleColor, fontWeight: FontWeight.w900),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.messenger_outline,
          ),
        )
      ],
    );
  }
}
