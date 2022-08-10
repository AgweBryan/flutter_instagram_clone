import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  final Rx<List<Post>> _posts = Rx<List<Post>>([]);

  List<Post> get posts => _posts.value;

  @override
  void onInit() {
    super.onInit();
    _posts.bindStream(firestore.collection('posts').snapshots().map((query) {
      List<Post> result = [];
      for (final element in query.docs) {
        result.add(Post.fromSnap(element));
      }
      return result;
    }));
  }
}
