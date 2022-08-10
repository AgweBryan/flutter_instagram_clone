import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String username;
  String uid;
  String id;
  List likes;
  List reports;
  int commentCount;
  List shareCount;
  String caption;
  String postUrl;
  String profilePhoto;

  Post({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.shareCount,
    required this.likes,
    required this.reports,
    required this.profilePhoto,
    required this.uid,
    required this.username,
    required this.postUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'profilePhoto': profilePhoto,
        'id': id,
        'likes': likes,
        'reports': reports,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'caption': caption,
        'postUrl': postUrl,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      caption: snapshot['caption'],
      commentCount: snapshot['commentCount'],
      id: snapshot['id'],
      shareCount: snapshot['shareCount'],
      likes: snapshot['likes'],
      reports: snapshot['reports'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postUrl: snapshot['postUrl'],
    );
  }
}
