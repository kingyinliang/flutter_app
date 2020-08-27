import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../../../components/card.dart';
import '../common/slideButton.dart';
import '../common/sliverTabBar.dart';

class AcceAddHomePage extends StatefulWidget {
  AcceAddHomePage({Key key}) : super(key: key);

  @override
  _AcceAddHomePageState createState() => _AcceAddHomePageState();
}

class _AcceAddHomePageState extends State<AcceAddHomePage> {
  bool _floatingActionButtonFlag = true;
  int _tabIndex = 0;

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    _floatingActionButtonFlag = index == 1 ? false : true;
    _tabIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: '辅料添加'),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
          tabChange: setFloatingActionButtonFlag,
          children: <Widget>[
            SizedBox(height: 5),
            PageHead(),
            SizedBox(height: 5),
          ],
          tabBarChildren: <Widget>[
            Tab(text: '煮料锅'),
            Tab(text: '辅料领用'),
            Tab(text: '增补料'),
          ],
          tabBarViewChildren: <Widget>[
            PotListWidget(),
            AcceReceiveTab(),
            MaterialAddTab(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
                child: _floatingActionButtonFlag
                    ? FloatingActionButton(
                        onPressed: () {
                          if (_tabIndex == 0) {
                            Navigator.pushNamed(context, '/sterilize/potAdd');
                          } else {
                            Navigator.pushNamed(
                                context, '/sterilize/materialAdd');
                          }
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: MdsWidthButton(
                  text: '提交',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 表头
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

// 煮料锅tab
class PotListWidget extends StatefulWidget {
  PotListWidget({Key key}) : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget> {
  List<SlideButton> list;
  List listWidget;
  List potArr = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  Widget removeBtn(index) {
    return InkWell(
      child: Container(
        width: 70.0,
        height: double.infinity,
        margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
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
        child: Center(
          child: Container(
            height: 40,
            child: RaisedButton(
                color: Colors.red,
                shape: CircleBorder(side: BorderSide(color: Colors.red)),
                child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'),
                    color: Colors.white, size: 30),
                onPressed: () {}),
          ),
        ),
      ),
      onTap: () {
        potArr.removeAt(index);
        setState(() {});
      },
    );
  }

  close() {
    for (int i = 0; i < listWidget.length; i++) {
      if (listWidget[i].currentState.translateX != 0) {
        listWidget[i].currentState.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    listWidget = List<LabeledGlobalKey<SlideButtonState>>();
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
      itemCount: potArr.length,
      itemBuilder: (context, index) {
        var key = GlobalKey<SlideButtonState>();
        listWidget.add(key);
        return SlideButton(
          key: key,
          singleButtonWidth: 70,
          child: ItemCard(carTitle: '煮料锅领用数量'),
          buttons: <Widget>[
            removeBtn(index),
          ],
          onDown: () => close(),
        );
      },
    );
  }
}

// 辅料领用tab
class AcceReceiveTab extends StatefulWidget {
  AcceReceiveTab({Key key}) : super(key: key);

  @override
  _AcceReceiveTabState createState() => _AcceReceiveTabState();
}

class _AcceReceiveTabState extends State<AcceReceiveTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data11'),
    );
  }
}

// 增补料tab
class MaterialAddTab extends StatefulWidget {
  MaterialAddTab({Key key}) : super(key: key);

  @override
  _MaterialAddTabState createState() => _MaterialAddTabState();
}

class _MaterialAddTabState extends State<MaterialAddTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}

// 单个card
class ItemCard extends StatefulWidget {
  final String carTitle;
  ItemCard({Key key, this.carTitle}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return MdsCard(
      child: Stack(
        children: <Widget>[
          Positioned(
              right: 0,
              top: 0,
              child: Icon(
                IconData(0xe62c, fontFamily: 'MdsIcon'),
                size: 16,
                color: Color(0xFF487BFF),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('11',
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
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
