import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/singleton_class.dart';
import '../utils/view_seperator.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _mainMenu = '',
      _altMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getMenu(),
        builder: (context, AsyncSnapshot snap) {
          if (snap.data != null) {
            MenuOrder model = snap.data;
            _altMenu = model.alternateMenu;
            _mainMenu = model.mainMenu;
            return LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints viewportConstraints) {
                  return Container(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight),
                        child: Column(
                          children: <Widget>[
                            MySingleton.putMargin(top: 20.0),
                            Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.orangeAccent),
                                /*image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://www.bootdey.com/img/Content/avatar/avatar7.png"),
                                  ),*/
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.orangeAccent,
                                child: Text(
                                  'J', style: TextStyle(fontSize: 80.0),),
                                foregroundColor: Colors.white,
                              ),
                            ),
                            MySingleton.putMargin(top: 10.0),
                            Text(
                              "John Doe",
                              textScaleFactor: 1.6,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            MySingleton.putMargin(top: 30.0),
                            Text(
                              "** Today's Menu **",
                              textScaleFactor: 1.4,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            MySingleton.putMargin(top: 6.0),
                            MySeparator(color: Colors.grey),
                            MySingleton.putMargin(top: 10.0),
                            Text("\nMain Menu : $_mainMenu",
                                textScaleFactor: 1.2),
                            MySingleton.putMargin(top: 10.0),
                            Text("Alternate Menu : $_altMenu",
                                textScaleFactor: 1.2),
                            MySingleton.putMargin(top: 30.0),
                            Text(
                              "*** You must have order main menu or alternate menu to avail snacks in evening. Otherwise you will not be able to get your snacks.",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Container(
              child: Center(child: Text(
                'Loading...', style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,)),
            );
          }
        },
      ),
    );
  }

  Future <MenuOrder> _getMenu() async {
    var data = await get(C.baseURL + C.getMenu);
    var jsonData = MenuOrder.fromJson(json.decode(data.body));
    return jsonData;
  }
}
