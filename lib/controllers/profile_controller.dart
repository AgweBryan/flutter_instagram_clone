import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  final Rx<String> _uid = "".obs;

  Map<String, dynamic> get user => _user.value;

  updateUserId(String id) {
    _uid.value = id;
    getUserData();
  }

  getUserData() async {
    List<Map<String, dynamic>> posts = [];

    dynamic userPosts = await firestore
        .collection('posts')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < userPosts.docs.length; i++) {
      final id = (userPosts.docs[i].data() as dynamic)['id'];
      final caption = (userPosts.docs[i].data() as dynamic)['caption'];
      final commentCount =
          (userPosts.docs[i].data() as dynamic)['commentCount'];
      final postUrl = (userPosts.docs[i].data() as dynamic)['postUrl'];
      final userLikes = (userPosts.docs[i].data() as dynamic)['likes'];
      final profilePhoto =
          (userPosts.docs[i].data() as dynamic)['profilePhoto'];
      final reports = (userPosts.docs[i].data() as dynamic)['reports'];
      final shareCount = (userPosts.docs[i].data() as dynamic)['shareCount'];
      final datePublished =
          (userPosts.docs[i].data() as dynamic)['datePublished'];
      final uid = (userPosts.docs[i].data() as dynamic)['uid'];
      final username = (userPosts.docs[i].data() as dynamic)['username'];

      final Post post = Post(
        caption: caption,
        commentCount: commentCount,
        id: id,
        shareCount: shareCount,
        likes: userLikes,
        reports: reports,
        profilePhoto: profilePhoto,
        datePublished: datePublished,
        postUrl: postUrl,
        uid: uid,
        username: username,
      );

      posts.add(post.toJson());
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();

    final userData = userDoc.data() as dynamic;

    String name = userData['name'];

    String userProfilePhoto = userData['profilePhoto'];

    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (final item in userPosts.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    final followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    final followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': userProfilePhoto,
      'name': name,
      'posts': posts,
    };
    update();
  }

  followUser() async {
    final followersDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    final followingDoc = await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('followers')
        .doc(_uid.value)
        .get();

    if (!followersDoc.exists && !followingDoc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
