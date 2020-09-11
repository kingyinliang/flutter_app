import 'package:flutter/material.dart';

import 'home/home.dart';
import 'message/message.dart';
import 'user/user.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  List<Widget> _pageList = [
    HomePage(),
    MessagePage(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._currentIndex,
        children: this._pageList,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        selectedItemColor: Color(0xFF487BFF),
        items: [
          BottomNavigationBarItem(
              icon: Icon(IconData(0xe6a7, fontFamily: 'MdsIcon')),
              title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xe634, fontFamily: 'MdsIcon')),
              title: Text("待办")),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xe63a, fontFamily: 'MdsIcon')),
              title: Text("我的"))
        ],
        onTap: (int index) => {
          setState(() {
            this._currentIndex = index;
          })
        },
      ),
    );
  }
}
