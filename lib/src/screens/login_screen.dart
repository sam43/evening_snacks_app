import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../blocs/bloc.dart';
import '../utils/singleton_class.dart';
import 'landing_screen.dart';

var _email = '',
    _password = '';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom),
      margin: EdgeInsets.all(20.0),
      child: ListView(
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
        MySingleton.putMargin(top: 20.0),
        _appLogo(),
        MySingleton.putMargin(bottom: 20.0),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Welcome to Bdjobs Sncaks App',
            style: TextStyle(
              fontSize: 26.0,
              fontFamily: 'Ranga',
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
        _setEmailValue(snap.data.toString());
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

  Widget _keepLoogedIn() {}

  Widget _submitLogin(BuildContext cxt) {
    return RaisedButton(
      child: Text(
        'Log in',
        style: TextStyle(color: Colors.white),
      ),
      padding: EdgeInsets.all(10.0),
      color: Colors.green,
      onPressed: () {
        FocusScope.of(cxt).requestFocus(FocusNode());
        print("email value: ${_getEmailValue()}");
        if (_getEmailValue() == 'a@c' && _getPassValue() == '1230') {
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
        print("pass value: ${_getPassValue()}");
      },
    );
  }
}

void _loginSuccess(bool ok) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged_in', ok);
}

void _setEmailValue(String s) {
  print("_setEmailValue value: $s");
  _email = s;
}

String _getEmailValue() {
  return _email;
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

