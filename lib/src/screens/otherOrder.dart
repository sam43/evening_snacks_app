import 'dart:convert';

import 'package:evening_snacks_app/src/blocs/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../network/models/models.dart';
import '../utils/constants.dart';
import '../utils/singleton_class.dart';

class MyOrderPage extends StatefulWidget {
  _MyOrderPageState createState() => _MyOrderPageState();
}


String _uID = '',
    _uName = '';

class _MyOrderPageState extends State<MyOrderPage> {
  //AnimationController _controller;
  List<String> _listAsync = [];
  int _value = 0;
  String s = '';
  bool visibilityDelete = true;
  bool visibilityOrder = false;
  MenuOrder model;
  String _itemName = 'Aam';
  String _rules = 'To give an order please select a menu and press order button. \nNote that you can not give order after 5:00 PM';
  String _rulesUpdate = 'To update your order please delete your order first. \nNote that you can\'t delete your order after 5:00 PM';

  @override
  void initState() {
    _getInfo();
    super.initState();
  }
  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return FutureBuilder(
              future: _getMenu(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  model = snapshot.data;
                  String altMenu = model.alternateMenu;
                  _listAsync = altMenu.split('/').toList();
                  return Container(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight),
                        child: Column(
                          children: <Widget>[
                            MySingleton.putMargin(top: 10.0),
                            _staticText(_rules, Colors.orange),
                            MySingleton.putMargin(bottom: 20.0),
                            orderBloc.isMenuNull() ? _text() : _listWidget(
                                context),
                            MySingleton.putMargin(top: 20.0),
                            orderBloc.isMenuNull() ? _submitButton(
                                context, 'Order', Colors.grey)
                                : _submitButton(context, 'Order', Colors.green),
                            MySingleton.putMargin(bottom: 30.0),
                            _staticText(_rulesUpdate, Colors.redAccent),
                            MySingleton.putMargin(bottom: 15.0),
                            _submitButton(
                                context, 'Delete Order', Colors.redAccent),
                            MySingleton.putMargin(bottom: 30.0),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(child: Text(
                      'Loading...', style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center,)),
                  );
                }
              },
            );
          }),
    );
  }

  Widget _listWidget(BuildContext cxt) {
    //print('list: $_listAsync');
    return Container(
      child: Wrap(
        direction: Axis.vertical,
        children: List<Widget>.generate(
          _listAsync.length, (int index) {
          return ChoiceChip(
            label: _getItemList(index),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : 0;
                _setItemName(_value);
                Toast.show('Selected item is "${_getItemName()}" ', cxt);
              });
            },
          );
        },
        ).toList(),
      ),
    );
  }


  Widget _getItemList(int index) {
    return Text(_listAsync[index]);
  }

  void _setItemName(int s) {
    _itemName = _listAsync[s];
  }

  String _getItemName() {
    return _itemName;
  }
}

Widget _text() {
  return Text('Order done already');
}

Future <MenuOrder> _getMenu() async {
  var data = await get(C.baseURL + C.getMenu);
  var jsonData = MenuOrder.fromJson(json.decode(data.body));

  return jsonData;
}

Widget _staticText(String s, Color c) {
  return Text(
    s,
    textScaleFactor: 1.0,
    textAlign: TextAlign.center,
    style: TextStyle(color: c, fontSize: 14.0,),);
}

Widget _submitButton(BuildContext cxt, String title, Color c) {
  return RaisedButton(
    child: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    padding: EdgeInsets.all(10.0),
    color: c,
    onPressed: () {
      _orderSubmit(true);
    },
  );
}

void _orderSubmit(bool b) {
  return;
}

/*Future <MenuOrder> _orderSnacks() async {
  var data = await get(C.baseURL + C.getMenu);
  var jsonData = MenuOrder.fromJson(json.decode(data.body));
  print('${jsonData.alternateMenu}');

  return jsonData;
}*/

Future <void> _getInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _uName = prefs.getString('user_name');
  _uID = prefs.getString('user_id');
  print('name:::: $_uName & ${_uName.runtimeType}, uID: $_uID');
  orderBloc.checkOrder(_uID.toString());
}

/*Future <String> _deleteOrder() async {
  var data = await get(C.baseURL + C.deleteOrder + '?userid=$uID');
  var jsonData = DeleteOrder.fromJson(json.decode(data.body));
  messageType = jsonData.messageType;
  if (messageType == '1') {
    Toast.show(
        'Order $uName has been deleted.', context,
        duration: 5);
  } else {
    Toast.show(
        C.somethingWrong, context,
        duration: 5);
  }
  return messageType;
}*/

