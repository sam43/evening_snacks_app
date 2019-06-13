class C {
  static String baseURL = 'http://172.16.9.235/snacks';
  static String userList = '/getuserlist.asp';
}


/*
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
}*/
