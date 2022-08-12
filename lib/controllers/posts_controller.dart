import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostsController extends GetxController {
  final Rx<List<Post>> _posts = Rx<List<Post>>([]);

  List<Post> get posts => _posts.value;

  @override
  void onInit() {
    super.onInit();

    // Get data from firestore
    _posts.bindStream(firestore.collection('posts').snapshots().map((query) {
      List<Post> result = [];
      for (final element in query.docs) {
        result.add(Post.fromSnap(element));
      }
      return result;
    }));
  }

  likePost(String id) async {
    final doc = await firestore.collection('posts').doc(id).get();

    final uid = authController.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection('posts').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('posts').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  shareVideo(Post post) async {
    final doc = await firestore.collection('posts').doc(post.id).get();

    final uid = authController.user.uid;
    if ((doc.data() as dynamic)['shareCount'].contains(uid)) {
      await Share.share('Check out this awesome post!! \n\n${post.postUrl}');
    } else {
      await Share.share('Check out this awesome post!! \n\n${post.postUrl}');

      await firestore.collection('posts').doc(post.id).update({
        'shareCount': FieldValue.arrayUnion([uid])
      });
    }
  }
}
