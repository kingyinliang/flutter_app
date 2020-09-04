import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import '../common/page_head.dart';
import '../common/item_card.dart';
import '../common/remove_btn.dart';

List potArr = [
  {
    'num1': '55',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '892',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '785',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  },
  {
    'num1': '892',
    'util': 'KG',
    'name': '1#煮料锅',
    'name1': '第3锅',
    'name2': '3#转运罐',
    'name3': '杀菌完黄豆酱',
    'name4': '2020052185001',
    'name5': '2020-05-26',
    'name6': '09:35',
    'name7': '12311公斤',
    'name8': '张三',
    'name9': '2020.05.21 18:29:20',
    'name10': '运转正常',
  }
];
List wrapList = [
  {'label': '', 'value': 'name'},
  {'label': '', 'value': 'name1'},
  {'label': '', 'value': 'name2'},
  {'label': '', 'value': 'name3'},
  {'label': '', 'value': 'name4'},
  {'label': '配置日期：', 'value': 'name5'},
  {'label': '添加时间', 'value': 'name6'},
  {'label': '剩余库存', 'value': 'name7'},
  {'label': '', 'value': 'name8'},
  {'label': '', 'value': 'name9'},
  {'label': '备注：', 'value': 'name10'},
];

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

  _initState() async {
    try {
      var res = await Sterilize.acceAddHomeApi({
        "materialCode": "SP04020002",
        "orderNo": "853000000514",
        "potOrderNo": "853000000514001"
      });
      print(res);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _initState();
            }));
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
            PageHead(
              title: '1#锅 第2锅',
              subTitle: '杀菌完黄豆酱',
              orderNo: '83300023456',
              potNo: '83300023456',
            ),
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
                            Navigator.pushNamed(
                                context, '/sterilize/acceAdd/potAdd');
                          } else {
                            Navigator.pushNamed(
                                context, '/sterilize/acceAdd/materialAdd');
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

// 煮料锅tab
class PotListWidget extends StatefulWidget {
  PotListWidget({Key key}) : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget> {
  List listWidget;

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
          child: ItemCard(
            carTitle: '煮料锅领用数量',
            cardMap: potArr[index],
            title: 'num1',
            subTitle: 'util',
            wrapList: wrapList,
          ),
          buttons: <Widget>[
            CardRemoveBtn(
              removeOnTab: () {
                potArr.removeAt(index);
                setState(() {});
              },
            ),
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
  List acceList = [
    {
      'name': 'M0203030411',
      'name1': ' 水',
      'child': [
        {'name': '100Kg', 'name1': '2020052995001'}
      ]
    },
    {
      'name': 'M0203030411',
      'name1': 'Y01',
      'child': [
        {'name': '100Kg', 'name1': '2020052995001'},
        {'name': '100Kg', 'name1': '2020052995001'},
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: acceList.length,
      itemBuilder: (context, index) {
        List<Widget> childList = [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: ColumnItem(
              addFlag: true,
              startText: acceList[index]['name'],
              endText: acceList[index]['name1'],
              onTap: () {},
            ),
          ),
        ];
        acceList[index]['child'].forEach((e) {
          childList.add(Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: SlideButton(
                child: ColumnItem(
                  startText: e['name'],
                  centerText: e['name1'],
                  onTap: () {},
                ),
                singleButtonWidth: 60,
                buttons: <Widget>[
                  Container(
                    width: 60,
                    color: Color(0xFFE8E8E8),
                    child: Center(
                      child: Container(
                        height: 24,
                        child: RaisedButton(
                            color: Colors.red,
                            shape: CircleBorder(
                                side: BorderSide(color: Colors.red)),
                            child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'),
                                color: Colors.white, size: 16),
                            onPressed: () {}),
                      ),
                    ),
                  )
                ]),
          ));
        });
        return Column(
          children: childList,
        );
      },
    );
  }
}

// 辅料单item
class ColumnItem extends StatefulWidget {
  final bool addFlag;
  final String startText;
  final String centerText;
  final String endText;
  final Function onTap;
  ColumnItem(
      {Key key,
      this.addFlag = false,
      this.startText = '',
      this.centerText = '',
      this.endText = '',
      this.onTap})
      : super(key: key);

  @override
  _ColumnItemState createState() => _ColumnItemState();
}

class _ColumnItemState extends State<ColumnItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.startText,
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
          SizedBox(width: 15),
          Text(
            widget.centerText,
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.endText,
              textAlign: TextAlign.right,
              style: TextStyle(color: Color(0xFF999999), fontSize: 17),
            ),
          ),
          SizedBox(width: 10),
          widget.addFlag == true
              ? InkWell(
                  child: Icon(
                    IconData(0xe69e, fontFamily: 'MdsIcon'),
                    size: 20,
                    color: Color(0xFF487BFF),
                  ),
                  onTap: widget.onTap,
                )
              : InkWell(
                  child: Icon(
                    IconData(0xe62c, fontFamily: 'MdsIcon'),
                    size: 18,
                    color: Color(0xFF487BFF),
                  ),
                  onTap: widget.onTap,
                )
        ],
      ),
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
  List listWidget;

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
          child: ItemCard(
            carTitle: '增补料领用数量',
            cardMap: potArr[index],
            title: 'num1',
            subTitle: 'util',
            wrapList: wrapList,
          ),
          buttons: <Widget>[
            CardRemoveBtn(
              removeOnTab: () {
                potArr.removeAt(index);
                setState(() {});
              },
            ),
          ],
          onDown: () => close(),
        );
      },
    );
  }
}
