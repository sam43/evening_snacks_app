import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/network/services/providers/user_login_provider.dart';

class DataRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<UserResponse> loginUser(String email, String pass) {
    return _apiProvider.userLogin(email, pass);
  }

  Future<MyOrder> checkUserOrder(String _gid) {
    print('userID2: $_gid');
    return _apiProvider.checkOrder(_gid);
  }

  Future<MakeOrder> makeUserOrder(String userid, String uname, String menu,
      {String corder}) {
    print('userIDmake2: $userid// $uname// $menu //$corder');
    return _apiProvider.makeOrder(userid, uname, menu, corder: corder);
  }
}
