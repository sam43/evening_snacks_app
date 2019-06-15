import 'dart:convert';
import 'dart:io';

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
  final titles = ['bike', 'boat', 'bus', 'car',
    'railway', 'run', 'subway', 'transit', 'walk'];
  List<User> users = [];

  //image upload
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';


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


  Future <List<User>> _getUsers() async {
    if (users.length == 0) {
      var data = await get(C.baseURL + C.userList);
      users = [];
      var jsonData = UserListModel.fromJson(json.decode(data.body));
      users = jsonData.user.toList();
    }
    return users;
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
              }
          );
        }
      },
    );
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
          onTap: () => MySingleton.showSnackBar(context, 'Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => MySingleton.showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => MySingleton.showSnackBar(context, 'More options'),
        ),
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

  void _removeItem(int index, User data) {
    setState(() {
      users.removeAt(index);
      Toast.show(
          'Data ${data.uname} has been deleted.', context,
          duration: 5);
    });
  }
}


