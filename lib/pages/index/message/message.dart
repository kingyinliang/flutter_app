import 'package:flutter/material.dart';
import '../../../components/sliver_tab_bar.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("消息列表",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
        ),
      ),
      body: SliverTabBarWidget(
        children: <Widget>[
          Container(
            height: 44,
          )
        ],
        tabBarChildren: <Widget>[
          Tab(text: '未查看'),
          Tab(text: '已查看'),
        ],
        tabBarViewChildren: <Widget>[
          MessageTab(),
          MessageTab(),
        ],
      ),
    );
  }
}

class MessageTab extends StatefulWidget {
  MessageTab({Key key}) : super(key: key);

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          MessageItem(),
          MessageItem(),
          MessageItem(),
        ],
      ),
    );
  }
}

class MessageItem extends StatefulWidget {
  MessageItem({Key key}) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Container(
        height: 60,
        padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '1#锅第一锅',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 17),
                  ),
                  Text(
                    '851000029046 工艺审核通过，请确认！',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color(0xFFCCCCCC),
            )
          ],
        ),
      ),
    );
  }
}
