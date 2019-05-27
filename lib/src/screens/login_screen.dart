import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../utils/singleton_class.dart';
import 'landing_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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

  /*
  * Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _loginTitle(),
            MySingleton.putMargin(all: 15.0),
            _emailTextField(),
            MySingleton.putMargin(all: 15.0),
            _passwordField(),
            MySingleton.putMargin(top: 50.0),
            //_keepLoogedIn(),
            _submitLogin(),
          ],
        ),
      )*/

  // inside scrollview
  /*
  * return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: ...,
      ),
    );
  * */

  Widget _loginTitle() {
    return Column(
      children: <Widget>[
        MySingleton.putMargin(top: 20.0),
        _appLogo(),
        MySingleton.putMargin(bottom: 20.0),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Welcome to Sncaks App',
            style: TextStyle(
              fontSize: 22.0,
              fontFamily: "assets/fonts/Ranga-Bold.ttf",
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
        return TextField(
          onChanged: bloc.changePassword,
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
        Navigator.push(
          cxt,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
    );
  }
}

@override
Widget _appLogo() {
  return Container(
    height: 100,
    width: 100,
    child: Image.asset("assets/humm.png"),
  );
}
