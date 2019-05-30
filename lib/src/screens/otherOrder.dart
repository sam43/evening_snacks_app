import 'package:flutter/material.dart';

class MyOrderPage extends StatefulWidget {
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  //AnimationController _controller;
  int _value = 1;

  /* @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }
*/
  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        children: List<Widget>.generate(
          4, (int index) {
          return ChoiceChip(
            label: _getItemList(index),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
            },
          );
        },
        ).toList(),
      ),
    );
  }
}

Widget _getItemList(int index) {
  final List<String> _list = [
    'Order Item 1',
    'Order Item 2',
    'Order Item 3',
    'Order Item 4'
  ];
  return Text(_list[index]);
}

