import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final Rx<List<Post>> _posts = Rx<List<Post>>([]);

  List<Post> get posts => _posts.value;

  @override
  void onInit() {
    super.onInit();
    _posts.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('favorites')
        .snapshots()
        .map((query) {
      List<Post> retVal = [];
      for (var element in query.docs) {
        retVal.add(Post.fromSnap(element));
      }
      return retVal;
    }));
  }

  addPostToFavorites(Post post) async {
    try {
      final currentUserDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .get();

      int len = currentUserDoc.docs.length;
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .doc('Fav $len')
          .set(post.toJson());

      Get.snackbar('Success', 'Post added to favorites successfully');
    } catch (e) {
      Get.snackbar("Error adding to fav", e.toString());
    }
  }

  removeFromFavorites(Post data) async {
    try {
      // Get user
      final currentUserDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .get();

      int ids = 0;
      for (var element in currentUserDoc.docs) {
        if (Post.fromSnap(element).id == data.id) {
          await firestore
              .collection('users')
              .doc(authController.user.uid)
              .collection('favorites')
              .doc('Fav $ids')
              .delete()
              .then((value) =>
                  Get.snackbar('Success', 'Post removed from favorites'));
        }
        ids++;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
