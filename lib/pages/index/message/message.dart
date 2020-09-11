import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../utils/pxunit.dart' show pxUnit;

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List messageOne = [
    {'id': '1', 'title': '1#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '2', 'title': '2#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '3', 'title': '3#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '4', 'title': '4#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '5', 'title': '5#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '6', 'title': '6#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '7', 'title': '7#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '8', 'title': '8#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '9', 'title': '9#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '10', 'title': '10#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '11', 'title': '11#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '12', 'title': '12#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '13', 'title': '13#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '14', 'title': '14#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '15', 'title': '15#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
    {'id': '16', 'title': '16#锅第一锅', 'subTitle': '851000029046 工艺审核通过，请确认！'},
  ];
  List messageTwo = [
    {
      'id': '1111',
      'title': '1111#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '2222',
      'title': '2222#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '3333',
      'title': '3333#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '4444',
      'title': '4444#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '5555',
      'title': '5555#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '6666',
      'title': '6666#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '7777',
      'title': '7777#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '8888',
      'title': '8888#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
    {
      'id': '9999',
      'title': '9999#锅第一锅',
      'subTitle': '851000029046 工艺审核通过，请确认！'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text("消息列表",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400)),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color(0xFF1677FF),
            labelColor: Color(0xFF1677FF),
            labelStyle: TextStyle(fontSize: 17),
            unselectedLabelColor: Color(0xFF333333),
            unselectedLabelStyle: TextStyle(fontSize: 17),
            tabs: <Widget>[
              Tab(text: '未查看'),
              Tab(text: '已查看'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: TabBarView(
          children: <Widget>[
            MessageTab(
                data: messageOne,
                changeCheckbox: (type, status, index) {
                  if (type) {
                    messageOne[index]['checkboxVal'] = jsonEncode(status);
                  } else {
                    messageOne.forEach((element) {
                      element['checkboxVal'] = jsonEncode(status);
                    });
                  }
                  setState(() {});
                }),
            MessageTab(
                data: messageTwo,
                changeCheckbox: (type, status, index) {
                  if (type) {
                    messageTwo[index]['checkboxVal'] = jsonEncode(status);
                  } else {
                    messageTwo.forEach((element) {
                      element['checkboxVal'] = jsonEncode(status);
                    });
                  }
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}

class MessageTab extends StatefulWidget {
  final List data;
  final Function changeCheckbox;
  MessageTab({Key key, this.data, this.changeCheckbox}) : super(key: key);

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab>
    with AutomaticKeepAliveClientMixin {
  bool _checkboxVal = false;

  onTap() {
    this._checkboxVal = !this._checkboxVal;
    widget.changeCheckbox(false, this._checkboxVal, 1);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    var tmp = true;
    widget.data.forEach((element) {
      if (element['checkboxVal'] == 'false' || element['checkboxVal'] == null) {
        tmp = false;
      }
    });
    this._checkboxVal = tmp;
  }

  @override
  void didUpdateWidget(MessageTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    var tmp = true;
    widget.data.forEach((element) {
      if (element['checkboxVal'] == 'false' || element['checkboxVal'] == null) {
        tmp = false;
      }
    });
    this._checkboxVal = tmp;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return MessageItem(
              title: widget.data[index]['title'],
              subTitle: widget.data[index]['subTitle'],
              checkboxVal:
                  (widget.data[index]['checkboxVal'] == 'true' ? true : false),
              change: (status) => widget.changeCheckbox(true, status, index),
            );
          },
        ),
        Positioned(
          width: pxUnit(375),
          bottom: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(pxUnit(12), 0, pxUnit(12), 0),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2.0),
                  color: Color(0x0D000000),
                  blurRadius: 4.0,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFF999999), width: 0.5),
                      ),
                      child: this._checkboxVal
                          ? Icon(
                              Icons.check,
                              color: Color(0xFF487BFF),
                              size: 14,
                            )
                          : SizedBox(),
                    ),
                  ),
                  SizedBox(width: pxUnit(10)),
                  Text('全选'),
                  Expanded(flex: 1, child: SizedBox()),
                  Container(
                    height: 26,
                    width: 80,
                    child: RaisedButton(
                      child: Text(
                        '标记已读',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      color: Color(0xFF1677FF),
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool checkboxVal;
  final Function change;
  MessageItem(
      {Key key,
      this.title,
      this.subTitle,
      this.checkboxVal = false,
      this.change})
      : super(key: key);

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
                    widget.title ?? '',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 17),
                  ),
                  Text(
                    widget.subTitle ?? '',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 13),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                widget.change(!widget.checkboxVal);
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF999999), width: 0.5),
                ),
                child: widget.checkboxVal
                    ? Icon(
                        Icons.check,
                        color: Color(0xFF487BFF),
                        size: 14,
                      )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
