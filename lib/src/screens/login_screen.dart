import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../blocs/bloc.dart';
import '../utils/singleton_class.dart';
import 'landing_screen.dart';

var _email = '',
    _password = '',
    _userID = '',
    _name = '',
    _gid = '';
List<Login> login;
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
      child: ListView(
        padding: EdgeInsets.all(20.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: <Widget>[
          _loginTitle(),
          MySingleton.putMargin(all: 15.0),
          _emailTextField(),
          MySingleton.putMargin(all: 15.0),
          _passwordField(),
          MySingleton.putMargin(top: 20.0),
          //_keepLoogedIn(),
          _submitLogin(context),
        ],
      ),
    );
  }

  Widget _loginTitle() {
    return Column(
      children: <Widget>[
        MySingleton.putMargin(top: 50.0),
        _appLogo(),
        MySingleton.putMargin(bottom: 10.0),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Bdjobs Snacks App',
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _emailTextField() {
    return StreamBuilder(
      stream: bloc.updateEmail,
      builder: (context, snap) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'Email address',
            fillColor: Colors.blueAccent,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: snap.error,
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return StreamBuilder(
      stream: bloc.updatePassword,
      builder: (context, snap) {
        _setPassValue(snap.data.toString());
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
            fillColor: Colors.blueAccent,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: snap.error,
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }

  Widget _submitLogin(BuildContext cxt) {
    return FutureBuilder(
      future: _tryLogin(),
      builder: (cxt, AsyncSnapshot snap) {
        if (snap.data != null) {
          return RaisedButton(
            child: Text(
              'Log in',
              style: TextStyle(color: Colors.white, fontFamily: 'Raleway',),
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.green,
            onPressed: () {
              Login log = snap.data[0];
              FocusScope.of(cxt).requestFocus(FocusNode());
              _callAPI(cxt, log);
            },
          );
        } else {
          return Container(
            child: Center(child: Text(
              'Loading...', style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,)),
          );
        }
      },
    );
  }

  void _callAPI(BuildContext cxt, Login data) {
    if (data.messageType == '1' && data != null) {
      _loginSuccess(true);
      _setEmailValue(data.email);
      _setNameValue(data.uname);
      _setGIDValue(data.gid);
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
  }
}

Future <List<Login>> _tryLogin() async {
  var data = await get(C.baseURL + C.orderList);
  login = [];
  var jsonData = UserLogin.fromJson(json.decode(data.body));
  login = jsonData.user.toList();
  return login;
}


void _loginSuccess(bool ok) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged_in', ok);
}

void _setEmailValue(String s) {
  print("_setEmailValue value: $s");
  _email = s;
}

String getEmailValue() {
  return _email;
}


void _setNameValue(String s) {
  _name = s;
}

String getNameValue() {
  return _name;
}


void _setUserIDValue(String s) {
  _userID = s;
}

String getUserIDValue() {
  return _userID;
}


void _setGIDValue(String s) {
  _gid = s;
}

String getGIDValue() {
  return _gid;
}

void _setPassValue(String s) {
  print("_setPassValue value: $s");
  _password = s;
}

String _getPassValue() {
  return _password;
}

Widget _appLogo() {
  return Container(
    height: 100,
    width: 100,
    child: Image.asset("assets/humm.png"),
  );
}

