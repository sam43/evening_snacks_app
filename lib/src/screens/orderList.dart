import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:http/http.dart" show get;
import 'package:toast/toast.dart';

import '../network/models/models.dart';
import '../utils/constants.dart';
import '../utils/hex_color_convert.dart';
import '../utils/singleton_class.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersListPage> {
  List<Order> orders = [];
  String uID = '',
      messageType = '',
      uName = 'XXX';
  int _orderListLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MySingleton.putMargin(top: 10.0),
            Text(
              'Order List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            MySingleton.putMargin(top: 10.0),
            Expanded(
              child: _generateList(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Order>> _getAllOrders() async {
    print('_getAllOrders() has called');
    if (orders.length == 0) {
      var data = await get(C.baseURL + C.orderList);
      orders = [];
      var jsonData = OrderListModel.fromJson(json.decode(data.body));
      orders = jsonData.order.toList();
    }
    return orders;
  }

  Widget _generateList(BuildContext context) {
    return FutureBuilder(
      future: _getAllOrders(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.data == null) {
          return Container(
            child: Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                )),
          );
        }
        /* else if (_orderListLength == 999) {
          return Container(
            child: Text(
              'No order has been placed yet.',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        }*/
        else {
          return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                if (index == snap.data.length - 1) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //_demoListItem(context, index, snap.data[index]),
                      _userListItem(context, index, snap.data[index]),
                      MySingleton.putMargin(bottom: 30.0)
                    ],
                  );
                } else
                  //return _demoListItem(context, index, snap.data[index]);
                  return _userListItem(context, index, snap.data[index]);
              });
        }
      },
    );
  }

  Widget _userListItem(BuildContext context, int i, Order data) {
    String menu = '',
        orderedBy = '';
    if (data != null) {
      print('data: ${data.uname}');
      uName = data.uname;
      menu = data.menu;
      orderedBy = data.orderedby;
    }
    /*else {
      return Container(
        child: Text(
          'No order has been placed yet.',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }*/
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 2.2,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          color: HexColor('#59ECF0F1'),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text(_getFirstLetter(uName)),
              foregroundColor: Colors.white,
            ),
            title: Text('$uName'),
            subtitle: Text('Menu: $menu \nOrdered By: $orderedBy'),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => MySingleton.showSnackBar(context, 'Share'),
        ),
      ],
      /*secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => MySingleton.showSnackBar(context, 'More options'),
        ),*/
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: true,
          onTap: () => _removeItem(i, data),
        ),
      ],
    );
  }

  Future<String> _deleteOrder() async {
    var data = await get(C.baseURL + C.deleteOrder + '?userid=$uID');
    var jsonData = DeleteOrder.fromJson(json.decode(data.body));
    messageType = jsonData.messageType;
    if (messageType == '1') {
      Toast.show('Order $uName has been deleted.', context, duration: 5);
      print('length of order: ${orders.length}');
    } else {
      Toast.show(C.somethingWrong, context, duration: 5);
      print('length of order: ${orders.length}');
    }
    return messageType;
  }

  void _removeItem(int index, Order data) async {
    setState(() {
      uID = data.userid;
      //uName = data.uname;
      orders.removeAt(index);
      _deleteOrder();
    });
  }

  String _getFirstLetter(String uName) {
    String fl = 'A';
    if (uName != null || uName != '') {
      try {
        fl = uName.substring(0, 1);
      } catch (e) {
        print('Exception found : $e');
      }
    } else
      fl = 'XXX';
    return fl;
  }
}
