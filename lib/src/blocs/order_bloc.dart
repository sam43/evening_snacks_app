import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/network/services/repositories/user_login_repo.dart';

class OrderBloc {
  String _msgType = '', _menu = '';
  final DataRepository _repository = DataRepository();

  checkOrder(String _gid) async {
    print('userID3: $_gid');
    MyOrder response = await _repository.checkUserOrder(_gid);
    _msgType = response.messageType;
    _menu = response.menu;
    isMenuNull();
    print('msgtype: $_msgType and menu: $_menu');
  }

  makeOrder(String userid, String uname, String menu, {String corder}) async {
    print('userIDmake3: $userid// $uname// $menu //$corder');
    MakeOrder response = await _repository.makeUserOrder(
        userid, uname, menu, corder: corder);
    _msgType = response.messageType;
    print('msgtypemakeOrder: $_msgType');
  }

  bool isMenuNull() {
    if (_menu == null) {
      return false;
    } else {
      return true;
    }
  }
}

final orderBloc = OrderBloc();
