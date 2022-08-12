import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/comment.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  String _postId = '';

  List<Comment> get comments => _comments.value;

  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(firestore
        .collection('posts')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retValue = [];
      for (var element in query.docs) {
        retValue.add(Comment.fromSnap(element));
      }
      return retValue;
    }));
  }

  likeComment(String id) async {}
  postComment(String commentText) async {
    try {
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .get();

      final allDocs = await firestore
          .collection('posts')
          .doc(_postId)
          .collection('comments')
          .get();

      String id = 'Comment ${allDocs.docs.length}';

      Comment comment = Comment(
        username: authController.username.value,
        comment: commentText.trim(),
        datePublished: DateTime.now(),
        likes: [],
        profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
        userId: authController.user.uid,
        commentId: id,
      );

      await firestore
          .collection('posts')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .set(comment.toJson());

      // Update comment count
      DocumentSnapshot doc =
          await firestore.collection('posts').doc(_postId).get();

      await firestore.collection('posts').doc(_postId).update({
        'commentCount': (doc.data() as dynamic)['commentCount'] + 1,
      });
    } catch (e) {
      Get.snackbar('Error', 'Error posting comment');
    }
  }
}
