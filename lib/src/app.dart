import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) => runApp(new MyApp()));*/
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
