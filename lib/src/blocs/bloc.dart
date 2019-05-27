import 'dart:async';

import 'validator.dart';

class Bloc with Validator {
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();

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

  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
