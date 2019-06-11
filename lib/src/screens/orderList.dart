import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MySingleton.putMargin(top: 10.0),
            Text('Order List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
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
          padding: EdgeInsets.all(10.0),
          color: HexColor('#59ECF0F1'),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text('${position + 1}'),
              foregroundColor: Colors.white,
            ),
            title: Text('Tile no $position'),
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
              Toast.show('position is $position', context, duration: 5);
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
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          if (index == titles.length - 1) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _demoListItem(context, index, titles[index]),
                MySingleton.putMargin(bottom: 30.0)
              ],
            );
          } else
            return _demoListItem(context, index, titles[index]);
        }
    );
  }

}
