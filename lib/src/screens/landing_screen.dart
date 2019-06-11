import 'package:evening_snacks_app/src/widgets/anchor_layout.dart';
import 'package:evening_snacks_app/src/widgets/fab_bottom_appbar.dart';
import 'package:evening_snacks_app/src/widgets/fab_with_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../app.dart';
import 'order.dart';
import 'orderList.dart';
import 'orderSummary.dart';
import 'otherOrder.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.orange, //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.green,
        fontFamily: 'Raleway',
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
  String _lastSelected = 'TAB: 0';
  int _currentIndex = 0;
  final List<Widget> _children = [
    OrderPage(),
    MyOrderPage(),
    OrdersListPage(),
    OrderSummaryPage()
  ];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      _currentIndex = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  @override
  Widget build(BuildContext context) {
    const RoundedRectangleBorder roundedRectangleBorder =
    RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(80.0, 10.0),
            bottomRight: Radius.elliptical(80.0, 10.0)),
        side: BorderSide(style: BorderStyle.none));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Snacks App",
          style: TextStyle(color: Colors.white,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe900, fontFamily: 'customIcon')),
            padding: EdgeInsets.only(right: 25.0),
            onPressed: () {
              Toast.show('logged out', context);
              _logout(context);
            },
          ),
        ],
        centerTitle: true,
        shape: roundedRectangleBorder,
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.orange,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: 'Menu'),
          FABBottomAppBarItem(iconData: Icons.layers, text: 'My order'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'List'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'Summary'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
      // This trailing comma makes auto-formatting nicer for build methods.
      body: _children[_currentIndex],
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.supervised_user_circle, Icons.perm_contact_calendar];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add your new order',
        child: Icon(Icons.add),
        elevation: 3.0,
      ),
    );
  }
}

void _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('logged_in');
  _loginSuccess(false);
  Navigator.pop(context);
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext ctx) => App()));
}

void _loginSuccess(bool ok) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged_in', ok);
}

/*
* Toast.show("Toast plugin app", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Color(0xFFB74093),
                    // we can use 'Colors.green'
                    textColor: Colors.yellow,
                    backgroundRadius: 5.0);

                    */

/*
* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _lastSelected,
              style: TextStyle(fontSize: 32.0),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('Go to Second Screen'),
              onPressed: () {
                //Use`Navigator` widget to push the second screen to out stack of screens
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
            ),
          ],
        ),
      ),
* */
