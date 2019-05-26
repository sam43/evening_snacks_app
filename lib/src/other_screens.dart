import 'package:flutter/material.dart';

import '../main.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          child: Text('Go back to First Screen'),
          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
      ),
    );
  }
}