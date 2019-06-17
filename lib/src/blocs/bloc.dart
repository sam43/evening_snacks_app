import 'dart:async';

import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/network/services/repositories/user_login_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'validator.dart';

class Bloc with Validator {
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject = BehaviorSubject<
      UserResponse>();

  updateEmailOnChange(String newValue) {
    _email.sink.add(newValue);
  }

  updateEmailOnChange1(String newValue) {
    _email.stream;
  }

  // OR these method

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  // Add data to stream
  Stream<String> get updateEmail =>
      _email.stream.asBroadcastStream().transform(validateEmail);

  Stream<String> get updatePassword =>
      _password.stream.asBroadcastStream().transform(validatePassword);

  loginUser(email, pass) async {
    UserResponse response = await _repository.loginUser(email, pass);
    _subject.sink.add(response);
  }

  BehaviorSubject<UserResponse> get subject => _subject;

  dispose() {
    _email.close();
    _password.close();
    _subject.close();
  }
}

final bloc = Bloc();
