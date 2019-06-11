import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'BLoC Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
        fontFamily: 'Raleway',
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        /*appBar: AppBar(
          title: Text('BLoC Login'),
        ),*/
        backgroundColor: Colors.white,
        body: LoginScreen(),
      ),
    );
  }
}
