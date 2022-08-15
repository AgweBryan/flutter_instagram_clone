import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/search_controller.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() => searchController.searchedUsers.isEmpty
          ? const Center(
              child: Text(
                'Search for users',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
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

  _appBar() {
    return AppBar(
      backgroundColor: mobileBackgroundColor,
      title: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Search for a user',
        ),
        onFieldSubmitted: (_) {
          searchController.searchUser(_);
        },
      ),
    );
  }
}
