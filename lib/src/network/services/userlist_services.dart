import 'dart:async' show Future;
import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import "package:http/http.dart" show get, post;

Future <List<User>> getUsers() async {
  List<User> users = [];
  if (users.length == 0) {
    var data = await get(C.baseURL + C.userList);
    users = [];
    var jsonData = UserListModel.fromJson(json.decode(data.body));
    users = jsonData.user.toList();
  }
  return users;
}