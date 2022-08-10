import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;

class PostsController extends GetxController {
  final Rx<List<model.User>> _users = Rx<List<model.User>>([]);

  List<model.User> get users => _users.value;

  @override
  void onInit() {
    super.onInit();
    _users.bindStream(firestore.collection('users').snapshots().map((query) {
      List<model.User> result = [];
      for (final element in query.docs) {
        result.add(model.User.fromSnap(element));
      }
      return result;
    }));
  }
}
