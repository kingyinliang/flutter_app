import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../../../components/raisedButton.dart';
import '../../../components/card.dart';
import '../../../components/slide_button.dart';
import '../../../components/sliver_tab_bar.dart';

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

// 删除按钮
class CardRemoveBtn extends StatefulWidget {
  final Function removeOnTab;
  CardRemoveBtn({Key key, this.removeOnTab}) : super(key: key);

  @override
  _CardRemoveBtnState createState() => _CardRemoveBtnState();
}

class _CardRemoveBtnState extends State<CardRemoveBtn> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: widget.removeOnTab),
          ),
        ),
      ),
      onTap: widget.removeOnTab,
    );
  }
}

// 单个card
class ItemCard extends StatefulWidget {
  final String carTitle;
  final String title;
  final String subTitle;
  final Map cardMap;
  final List wrapList;
  ItemCard(
      {Key key,
      this.carTitle = '',
      this.cardMap,
      this.title,
      this.subTitle,
      this.wrapList})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  List colorList = [0xFFCDDDFD, 0xFFD3EEF9, 0xFFF8D0CB, 0xFFCDF3E4, 0xFFFCEBB9];
  int index = -1;
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
                  Text(
                      widget.cardMap[widget.title] == null
                          ? ''
                          : widget.cardMap[widget.title],
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 40.0,
                          color: Color(0xFF242446),
                          fontWeight: FontWeight.w500)),
                  Text(
                      widget.cardMap[widget.subTitle] == null
                          ? ''
                          : widget.cardMap[widget.subTitle],
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
                  Text(widget.carTitle,
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: widget.wrapList.asMap().keys.map((i) {
                  if (index > 3) {
                    index = -1;
                  }
                  index++;
                  return Container(
                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                    decoration: BoxDecoration(
                        color: Color(colorList[index]),
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    child: Text(widget.wrapList[i]['label'] +
                        (widget.cardMap[widget.wrapList[i]['value']] == null
                            ? ''
                            : widget.cardMap[widget.wrapList[i]['value']])),
                  );
                }).toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
