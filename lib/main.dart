import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'src/other_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snacks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () {},),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add_to_home_screen), onPressed: () {},),
            IconButton(icon: Icon(Icons.account_balance), onPressed: () {},),
            SizedBox(width: 50,),
            IconButton(icon: Icon(Icons.call), onPressed: () {},),
            IconButton(icon: Icon(Icons.menu), onPressed: () {},),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.red,
              child: Text('Go to Second Screen'),
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens

                Toast.show("Toast plugin app", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Color(0xFFB74093),
                    // we can use 'Colors.green'
                    textColor: Colors.yellow,
                    backgroundRadius: 5.0
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
