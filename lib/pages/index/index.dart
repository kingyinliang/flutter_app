import 'package:flutter/material.dart';
import 'home/home.dart';
import 'message/message.dart';
import 'user/user.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/api/http/socket.dart';
import 'package:dfmdsapp/config/config_init.dart';

class IndexPage extends StatefulWidget {
  final arguments;
  IndexPage({Key key, this.arguments}) : super(key: key);

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

  _initState() async {
    if (widget.arguments['page'] != null) {
      setState(() {
        _currentIndex = widget.arguments['page'];
      });
    }
    if (ConfigInt.connect == null) {
      await ConfigInt.connectivityInit();
    }

    try {
      var loginUserId = await SharedUtil.instance.getStorage('loginUserId');
      WebSocketManager.initSocket(loginUserId);
    } catch (e) {}
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

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
