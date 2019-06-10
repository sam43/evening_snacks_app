import 'package:flutter/material.dart';

import '../utils/singleton_class.dart';
import '../utils/view_seperator.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => new _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      /*color: Colors.blueGrey,*/
      child: Center(
          child: Column(
        children: <Widget>[
          MySingleton.putMargin(top: 20.0),
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://www.bootdey.com/img/Content/avatar/avatar7.png"),
                )),
            /*child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      fit: BoxFit.fill,
                      image: 'https://picsum.photos/250?image=9',
                    ),*/
          ),
          MySingleton.putMargin(top: 10.0),
          Text(
            "John Doe",
            textScaleFactor: 1.6,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          MySingleton.putMargin(top: 30.0),
          Text("** Today's Menu **", textScaleFactor: 1.4,
            style: TextStyle(fontWeight: FontWeight.bold),),
          MySingleton.putMargin(top: 6.0),
          MySeparator(color: Colors.grey),
          MySingleton.putMargin(top: 10.0),
          Text("Main Menu : Muri chanachurrr...", textScaleFactor: 1.2),
          MySingleton.putMargin(top: 10.0),
          Text("Alternate Menu : Doi chira", textScaleFactor: 1.2),
          MySingleton.putMargin(top: 30.0),
          Text(
            "*** You must have order main menu or alternate menu to avail snacks in evening. Otherwise you will not be able to get your snacks.",
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
        ],
      )),
    ));
  }
}
