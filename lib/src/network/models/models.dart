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
