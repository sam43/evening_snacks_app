import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'BLoC Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.green
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        /*appBar: AppBar(
          title: Text('BLoC Login'),
        ),*/
        body: LoginScreen(),
      ),
    );
  }
}
