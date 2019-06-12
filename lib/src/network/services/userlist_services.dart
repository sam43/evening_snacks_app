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

Future /*<List<User>>*/ loadProduct() async {
  var jsonProduct = await get(C.baseURL + C.userList);
  final jsonResponse = json.decode(jsonProduct.body);
  UserListModel product = UserListModel.fromJson(jsonResponse);
  List<User> users = [];
  users = jsonResponse['users'];
  print('product: ${jsonResponse['users']} // ${users[3]}');
  //return users;
}