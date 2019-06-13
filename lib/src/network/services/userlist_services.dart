import 'dart:async' show Future;
import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import "package:http/http.dart" show get, post;

/*Future<String> _loadProductAsset() async {
  return await rootBundle.loadString('assets/product.json');
}*/
/*
Product _parseJsonForCrossword(String jsonString) {
  Map JSON = json.decode(jsonString);
  List<Image> words = new List<Image>();
  for (var word in JSON['across']) {
    words.add(new Image(word['number'], word['word']));
  }
  return new Product(JSON['id'], JSON['name'], new Image(words));
}
*/

Future <List<User>> getUsers() async {
  var data = await get(C.baseURL + C.userList);
  List<User> users = [];
  var jsonData = UserListModel.fromJson(json.decode(data.body));
  users = jsonData.user.toList();
  return users;
}