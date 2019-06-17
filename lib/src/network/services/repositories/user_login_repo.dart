import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/network/services/providers/user_login_provider.dart';

class UserRepository {
  UserLoginProvider _apiProvider = UserLoginProvider();

  Future<UserResponse> loginUser(String email, String pass) {
    return _apiProvider.userLogin(email, pass);
  }

  Future<MyOrder> checkUserOrder(String _gid) {
    print('userID2: $_gid');
    return _apiProvider.checkOrder(_gid);
  }
}
