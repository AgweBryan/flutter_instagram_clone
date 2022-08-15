import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;

class SearchController extends GetxController {
  final Rx<List<model.User>> _searchedUsers = Rx<List<model.User>>([]);

  List<model.User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<model.User> retVal = [];

      for (final element in query.docs) {
        retVal.add(model.User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
