import 'dart:async' show Future;
import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import "package:http/http.dart" show get, post;
Future <List<User>> getUsers() async {
  var data = await get(C.baseURL + C.userList);
  List<User> users = [];
  var jsonData = UserListModel.fromJson(json.decode(data.body));
  users = jsonData.user.toList();
  return users;
}