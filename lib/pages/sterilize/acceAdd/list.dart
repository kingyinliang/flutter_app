import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';

class AcceAddListPage extends StatefulWidget {
  AcceAddListPage({Key key}) : super(key: key);

  @override
  _AcceAddListPageState createState() => _AcceAddListPageState();
}

class _AcceAddListPageState extends State<AcceAddListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: '辅料添加'),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
          children: <Widget>[HeadSearchWidget()],
          tabBarChildren: <Widget>[
            Tab(text: '未录入'),
            Tab(text: '已保存'),
            Tab(text: '已提交'),
          ],
          tabBarViewChildren: <Widget>[
            Text('a'),
            Text('a'),
            Text('a'),
          ],
        ),
      ),
    );
  }
}

class HeadSearchWidget extends StatefulWidget {
  HeadSearchWidget({Key key}) : super(key: key);

  @override
  _HeadSearchWidgetState createState() => _HeadSearchWidgetState();
}

class _HeadSearchWidgetState extends State<HeadSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Color(0xFFF5F5F5),
      child: Text('data'),
    );
  }
}
