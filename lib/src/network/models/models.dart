// User list models
class UserListModel {
  List<User> user;

  UserListModel({this.user});

  factory UserListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['users'] as List;
    //print(list.runtimeType);
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
    //print(list.runtimeType);
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


// user order

class MyOrder {
  String messageType;
  String menu;

  MyOrder(this.messageType, {this.menu});

  MyOrder.fromJson(Map<String, dynamic> jsonResponse) {
    messageType = jsonResponse['messageType'];
    menu = jsonResponse['menu'];
  }

  MyOrder.withError(String errorValue) : menu = '';
}

// make order

class MakeOrder {
  String messageType;

  MakeOrder(this.messageType);

  MakeOrder.fromJson(Map<String, dynamic> jsonResponse) {
    messageType = jsonResponse['messageType'];
  }

  MakeOrder.withError(String errorValue) : messageType = '';
}


// User login
class UserLogin {
  List<Login> user;

  UserLogin({this.user});

  factory UserLogin.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['login'] as List;
    //print(list.runtimeType);
    List<Login> usersList = list.map((i) => Login.fromJson(i)).toList();

    return UserLogin(user: usersList);
  }
}

class Login {
  String uname;
  String gid;
  String email;
  String messageType;

  Login(this.uname, this.gid, this.email, this.messageType);

  Login.fromJson(Map<String, dynamic> jsonResponse) {
    uname = jsonResponse['uname'];
    gid = jsonResponse['gid'];
    email = jsonResponse['Email'];
    messageType = jsonResponse['messageType'];
  }
}
