import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/favorites_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/views/widgets/post_card.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  final FavoritesController _favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() => _favoritesController.posts.isEmpty
          ? const Center(
              child: Text('No post yet'),
            )
          : ListView.builder(
              itemCount: _favoritesController.posts.length,
              itemBuilder: (context, i) {
                final post = _favoritesController.posts[i];
                return PostCard(
                  post: post,
                );
              },
            )),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: mobileBackgroundColor,
      title: const Text(
        'Favorites',
        style: TextStyle(
            fontSize: 20, color: purpleColor, fontWeight: FontWeight.w900),
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
