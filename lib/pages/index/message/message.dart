import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dfmdsapp/utils/pxunit.dart' show pxUnit;
import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/toast.dart';
import 'package:dfmdsapp/api/http/msg.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  List messageOne = [];
  List messageTwo = [];
  var eventListen;

  _initState({type: false}) async {
    try {
      var loginUserId = await SharedUtil.instance.getStorage('loginUserId');
      var resOne = await Common.msgQueryApi({
        'current': 1,
        'size': 9999999,
        'read': 0,
        'user': loginUserId,
      });
      var resTwo = await Common.msgQueryApi({
        'current': 1,
        'size': 9999999,
        'read': 1,
        'user': loginUserId,
      });
      messageOne = resOne['data']['records'];
      messageTwo = resTwo['data']['records'];
      if (type) $successToast(context, msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _bottomBtnClick() async {
    List redList = [];
    messageOne.forEach((element) {
      if (element['checkboxVal'] == 'true') {
        redList.add(element['msgId']);
      }
    });
    if (redList.length > 0) {
      try {
        var loginUserId = await SharedUtil.instance.getStorage('loginUserId');
        await Common.msgReadApi({
          'ids': redList,
          'userId': loginUserId,
        });
        _initState(type: true);
      } catch (e) {}
    } else {
      warningToast(msg: '请勾选消息');
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    eventListen = EventBusUtil.getInstance().on<MsgEvent>().listen((data) {
      setState(() {
        messageOne.insert(0, data.msg);
      });
    });
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    eventListen.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: PreferredSize(
            preferredSize: Size.fromHeight(42),
            child: Center(
              child: Text("消息列表",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
            ),
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
                bottomBtnClick: _bottomBtnClick,
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
                bottomBtn: false,
                bottomBtnClick: _bottomBtnClick,
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
  final Function bottomBtnClick;
  final bool bottomBtn;
  MessageTab(
      {Key key,
      this.data,
      this.changeCheckbox,
      this.bottomBtnClick,
      this.bottomBtn = true})
      : super(key: key);

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
          padding: EdgeInsets.fromLTRB(0, 10, 0, widget.bottomBtn ? 50 : 10),
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return MessageItem(
              bottomBtn: widget.bottomBtn,
              title: widget.data[index]['workShopName'],
              subTitle: widget.data[index]['msgContent'],
              checkboxVal:
                  (widget.data[index]['checkboxVal'] == 'true' ? true : false),
              change: (status) => widget.changeCheckbox(true, status, index),
            );
          },
        ),
        widget.bottomBtn
            ? Positioned(
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
                              border: Border.all(
                                  color: Color(0xFF999999), width: 0.5),
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
                            onPressed: widget.bottomBtnClick,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class MessageItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool checkboxVal;
  final bool bottomBtn;
  final Function change;
  MessageItem(
      {Key key,
      this.title,
      this.subTitle,
      this.checkboxVal = false,
      this.bottomBtn = false,
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
            widget.bottomBtn
                ? InkWell(
                    onTap: () {
                      widget.change(!widget.checkboxVal);
                    },
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFF999999), width: 0.5),
                      ),
                      child: widget.checkboxVal
                          ? Icon(
                              Icons.check,
                              color: Color(0xFF487BFF),
                              size: 14,
                            )
                          : SizedBox(),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
