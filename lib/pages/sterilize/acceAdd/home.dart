import 'package:flutter/material.dart';
import '../../../components/appBar.dart';

class AcceAddHomePage extends StatefulWidget {
  AcceAddHomePage({Key key}) : super(key: key);

  @override
  _AcceAddHomePageState createState() => _AcceAddHomePageState();
}

class _AcceAddHomePageState extends State<AcceAddHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MdsAppBarWidget(),
        backgroundColor: Color(0xFFF5F5F5),
        body: TabsWidget(),
      ),
    );
  }
}

class PageHead extends StatefulWidget {
  PageHead({Key key}) : super(key: key);

  @override
  _PageHeadState createState() => _PageHeadState();
}

class _PageHeadState extends State<PageHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 92,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: Color(0xF2F2F2FF),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('1#锅 第2锅',
                  style: TextStyle(fontSize: 18.0, color: Color(0xFF333333))),
              SizedBox(height: 6),
              Text('杀菌完黄豆酱',
                  style: TextStyle(fontSize: 15.0, color: Color(0xFF333333))),
              SizedBox(height: 6),
              Text('生产订单：83300023456',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
              SizedBox(height: 6),
              Text('锅单号：83300023456',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
            ],
          )
        ],
      ),
    );
  }
}

class TabsWidget extends StatefulWidget {
  TabsWidget({Key key}) : super(key: key);

  @override
  _TabsWidgetState createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
            child: PageHead(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          //中间悬浮subtitle
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            // ignore: deprecated_member_use
            child: SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              pinned: true,
              title: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xFF1677FF),
                labelColor: Color(0xFF1677FF),
                unselectedLabelColor: Color(0xFF333333),
                tabs: <Widget>[
                  Tab(text: '煮料锅'),
                  Tab(text: '辅料领用'),
                  Tab(text: '增补料'),
                ],
              ),
            ),
          )
        ];
      },
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PotListWidget(),
            Text('data2'),
            Text('data3'),
          ],
        ),
      ),
    );
  }
}

class PotListWidget extends StatefulWidget {
  PotListWidget({Key key}) : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget> {
  Widget potListItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3.0),
            color: Color(0x0C000000),
            blurRadius: 4.0,
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('892',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 40.0,
                          color: Color(0xFF242446),
                          fontWeight: FontWeight.w500)),
                  Text('KG',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF333333),
                          height: 3.0)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    IconData(0xe621, fontFamily: 'MdsIcon'),
                    size: 12.0,
                    color: Color(0xFF999999),
                  ),
                  SizedBox(width: 3.0),
                  Text('煮料锅领用数量',
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(0xFFCDDDFD),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text('data'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      children: <Widget>[potListItem()],
    );
  }
}
