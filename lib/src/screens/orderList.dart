import 'dart:convert';

import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:http/http.dart" show get, post;
import 'package:toast/toast.dart';

import '../utils/hex_color_convert.dart';
import '../utils/singleton_class.dart';

class OrdersListPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersListPage> {
  final titles = ['bike', 'boat', 'bus', 'car',
    'railway', 'run', 'subway', 'transit', 'walk'];

  @override
  Widget build(BuildContext context) {
    //_test();
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
            Expanded(child: _generateList(context)),
          ],
        ),
      ),
    );
  }

  Widget _demoListItem(BuildContext context, int position, String item) {
    const RoundedRectangleBorder roundedRectangleBorder =
    RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)),
        side: BorderSide(style: BorderStyle.none));

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
              child: Text('${position + 1}'),
              foregroundColor: Colors.white,
            ),
            title: Text('Tile no $item'),
            subtitle: Text('Item name $item'),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar(context, 'More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              titles.remove(titles[position]);
              Toast.show(
                  'position is $position and length: ${titles.length}', context,
                  duration: 5);
            });
          },
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Widget _generateList(BuildContext context) {
    return FutureBuilder(
      future: _getUsers(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.data == null) {
          return Container(
            child: Center(child: Text(
              'Loading...', style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,)),
          );
        } else {
          return ListView.builder(
              itemCount: snap.data,
              itemBuilder: (BuildContext context, index) {
                if (index == snap.data - 1) {
                  print('data: ${snap.data[index].uname}');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //_demoListItem(context, index, snap.data[index]),
                      _userListItem(context, index, snap.data),
                      MySingleton.putMargin(bottom: 30.0)
                    ],
                  );
                } else
                  //return _demoListItem(context, index, snap.data[index]);
                  return _userListItem(context, index, snap.data);
              }
          );
        }
      },
    );
  }

  Future<List<User>> _getUsers() async {
    var data = await get(C.baseURL + C.userList);
    List<User> users = [];
    var jsonData = UserListModel.fromJson(json.decode(data.body));
    //var jsonData = json.decode(data.body);
    /*print('users: ${jsonData.user}');
    print('usersType: ${jsonData.user.runtimeType}');
    print('json: $jsonData');*/

    print('start');
    users = jsonData.user.toList();
    print('userlistaa: ${users.runtimeType}');
    print('end');

    for (var u in users) {
      User user = User(u.uname, u.gid, u.messageType);
      users.add(user);
    }
    print('length of array: ${users.length}');
    return users;
  }

  void _test() async {
    var data = await get(C.baseURL + C.userList);
    //var jsonData = UserListModel.fromJson(json.decode(data.body));
    var jsonData = json.decode(data.body);
    print('json: $jsonData');
    List<UserListModel> users = [];
    users = jsonData['users'] as List;
    print(users.runtimeType);
  }

  Widget _userListItem(BuildContext context, int i, User data) {
    print('data: ${data.uname}');
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
              child: Text('A'),
              foregroundColor: Colors.white,
            ),
            title: Text('${data.uname}'),
            subtitle: Text('Gid: ${data.gid}'),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar(context, 'More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              titles.remove(data);
              Toast.show(
                  'Data ${data.uname} has been deleted.', context,
                  duration: 5);
            });
          },
        ),
      ],
    );
  }
}

