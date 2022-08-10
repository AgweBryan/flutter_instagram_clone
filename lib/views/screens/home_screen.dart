import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/posts_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final PostsController _postsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _postsController.posts.isEmpty
          ? const Center(
              child: Text('No post yer'),
            )
          : ListView.builder(
              itemCount: _postsController.posts.length,
              itemBuilder: (context, i) {
                final post = _postsController.posts[i];
                return ListTile(
                  leading:
                      CircleAvatar(backgroundImage: NetworkImage(post.postUrl)),
                  title: Text(post.username),
                );
              },
            )),
    );
  }
}
