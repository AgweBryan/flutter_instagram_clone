import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  dynamic datePublished;
  List likes;
  String profilePhoto;
  String commentId;
  String userId;

  Comment({
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.commentId,
    required this.profilePhoto,
    required this.userId,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'commentId': commentId,
        'userId': userId,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      commentId: snapshot['commentId'],
      userId: snapshot['userId'],
    );
  }
}
