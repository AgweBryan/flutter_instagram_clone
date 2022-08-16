import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';

import 'package:flutter_instagram_clone/models/user.dart' as model;

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
}
