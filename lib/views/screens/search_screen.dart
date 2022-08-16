import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/posts_controller.dart';
import 'package:flutter_instagram_clone/controllers/search_controller.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() => searchController.searchedUsers.isEmpty
          ? _showTiles()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemCount: searchController.searchedUsers.length,
              itemBuilder: (context, i) {
                User user = searchController.searchedUsers[i];
                return ListTile(
                  onTap: () {},
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: user.profilePhoto,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              },
            )),
    );
  }

  _showTiles() {
    final PostsController _postController = Get.find();
    List<Post> posts = _postController.posts;
    return GridView.builder(
      semanticChildCount: posts.length,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 2),
        ],
      ),
      itemCount: posts.length,
      itemBuilder: (context, i) => CachedNetworkImage(
        imageUrl: posts[i].postUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: mobileBackgroundColor,
      title: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Search for a user',
        ),
        // onFieldSubmitted: (_) {
        //   searchController.searchUser(_);
        // },
        onChanged: (value) {
          if (value.isEmpty) {
            return;
          } else {
            searchController.searchUser(value);
          }
        },
      ),
    );
  }
}
