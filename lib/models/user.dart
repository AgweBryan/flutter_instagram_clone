import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;

  User({
    required this.email,
    required this.name,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'profilePhoto': profilePhoto,
        'email': email,
        'uid': uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        name: snapshot['name'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid']);
  }
}
