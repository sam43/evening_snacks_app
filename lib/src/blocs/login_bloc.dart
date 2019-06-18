import 'dart:async';

import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/network/services/repositories/user_login_repo.dart';
import 'package:evening_snacks_app/src/screens/landing_screen.dart';
import 'package:evening_snacks_app/src/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Bloc with Validator {
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();
  final DataRepository _repository = DataRepository();
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

  loginUser(email, pass, cxt, page) async {
    UserResponse response = await _repository.loginUser(email, pass);
    String _msgType = response.user[0].messageType;
    _setNameValue(response.user[0].uname);
    _setEmailValue(response.user[0].email);
    _setUserIDValue(response.user[0].gid);
    if (_msgType == '1') {
      _loginSuccess(true);
      Navigator.pushReplacement(
        cxt,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
    else {
      Toast.show("Login credentials are not correct. \nTry again", cxt,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.redAccent,
          // we can use 'Colors.green'
          textColor: Colors.white,
          backgroundRadius: 10.0);
    }
    //_subject.sink.add(response);
  }

  //BehaviorSubject<UserResponse> get subject => _subject;

  dispose() {
    _email.close();
    _password.close();
    _subject.close();
  }

  void _loginSuccess(bool ok) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged_in', ok);
  }


  void _setEmailValue(String s) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', s);
  }

  void _setNameValue(String s) async {
    final prefs = await SharedPreferences.getInstance();
    print('Name: $s');
    prefs.setString('user_name', s);
  }

  void _setUserIDValue(String s) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', s);
  }

}

final bloc = Bloc();
