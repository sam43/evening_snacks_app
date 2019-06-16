// User list models
class UserListModel {
  List<User> user;

  UserListModel({this.user});

  factory UserListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['users'] as List;
    print(list.runtimeType);
    List<User> usersList = list.map((i) => User.fromJson(i)).toList();

    return UserListModel(user: usersList);
  }
}
class User {
  String uname;
  String gid;
  String messageType;

  User(this.uname, this.gid, this.messageType);

  User.fromJson(Map<String, dynamic> jsonResponse) {
    uname = jsonResponse['uname'];
    gid = jsonResponse['gid'];
    messageType = jsonResponse['messageType'];
  }
}

// Orderlist models

class OrderListModel {
  List<Order> order;

  OrderListModel({this.order});

  factory OrderListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['orders'] as List;
    print(list.runtimeType);
    List<Order> usersList = list.map((i) => Order.fromJson(i)).toList();

    return OrderListModel(order: usersList);
  }
}

class Order {
  String uname;
  String menu;
  String userid;
  String orderedby;

  Order(this.uname, this.menu, this.userid, this.orderedby);

  Order.fromJson(Map<String, dynamic> jsonResponse) {
    uname = jsonResponse['uname'];
    menu = jsonResponse['menu'];
    userid = jsonResponse['userid'];
    orderedby = jsonResponse['orderedby'];
  }
}

// Order delete

class DeleteOrder {
  String messageType;

  DeleteOrder(this.messageType);

  DeleteOrder.fromJson(Map<String, dynamic> jsonResponse) {
    messageType = jsonResponse['messageType'];
  }
}

// Menu for order

class MenuOrder {
  String messageType;
  String mainMenu;
  String alternateMenu;

  MenuOrder(this.messageType, this.mainMenu, this.alternateMenu);

  MenuOrder.fromJson(Map<String, dynamic> jsonResponse) {
    messageType = jsonResponse['messageType'];
    mainMenu = jsonResponse['mainMenu'];
    alternateMenu = jsonResponse['AlternateMenu'];
  }
}