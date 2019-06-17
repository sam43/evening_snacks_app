class UserResponse {
  final List<User> user;

  UserResponse(this.user);

  UserResponse.fromJson(Map<String, dynamic> json)
      : user =
            (json["login"] as List).map((i) => new User.fromJson(i)).toList();

  UserResponse.withError(String errorValue) : user = List();
}

class User {
  final String uname;
  final String gid;
  final String email;
  final String messageType;

  User(this.uname, this.gid, this.email, this.messageType);

  User.fromJson(Map<String, dynamic> json)
      : uname = json["uname"],
        gid = json["gid"],
        email = json["email"],
        messageType = json["messageType"];
}
