import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';
import 'package:dfmdsapp/components/no_data.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/components/toast.dart';

import '../common/page_head.dart';
import '../common/item_card.dart';
import '../../../components/remove_btn.dart';

class AcceAddHomePage extends StatefulWidget {
  final arguments;
  AcceAddHomePage({Key key, this.arguments}) : super(key: key);

  @override
  _AcceAddHomePageState createState() => _AcceAddHomePageState();
}

class _AcceAddHomePageState extends State<AcceAddHomePage> {
  bool _floatingActionButtonFlag = true;
  int _tabIndex = 0;
  var steCookingConsumeFlag;
  List potList = [];
  List acceList = [];
  List materialList = [];
  bool potStatus = true;
  bool acceStatus = true;
  bool materialStatus = true;

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    if (index == 0) {
      if (potList.length > 0) {
        _floatingActionButtonFlag = potStatus && steCookingConsumeFlag == '1';
      } else {
        _floatingActionButtonFlag = steCookingConsumeFlag == '1';
      }
    }
    if (index == 1) {
      _floatingActionButtonFlag = false;
    }
    if (index == 2) {
      if (materialList.length > 0) {
        _floatingActionButtonFlag = materialStatus;
      } else {
        _floatingActionButtonFlag = true;
      }
    }
    _tabIndex = index;
    setState(() {});
  }

  bool getStatus(List arr) {
    bool st = false;
    arr.forEach((item) {
      if (item['checkStatus'] == 'N' ||
          item['checkStatus'] == 'R' ||
          item['checkStatus'] == 'S' ||
          item['checkStatus'] == 'T' ||
          item['checkStatus'] == '' ||
          item['checkStatus'] == true) {
        st = true;
      }
    });

    return st;
  }

  _initState({type: false}) async {
    try {
      var res = await Sterilize.acceAddHomeApi({
        "materialCode": widget.arguments['potNum']['materialCode'],
        "orderNo": widget.arguments['potNum']['orderNo'],
        "potOrderNo": widget.arguments['potNum']['potNo']
      });
      setState(() {
        steCookingConsumeFlag = res['data']['steCookingConsumeFlag'];
        potList = res['data']['steCookingConsume'];
        acceList = _acceData(res['data']['steAccessoriesConsume']);
        materialList = res['data']['newSteAccessoriesConsume'];
        potList.forEach((element) {
          element['potNoName'] = '${element['potNo']}#锅';
          element['cookingNumName'] = '第${element['cookingNum']}锅';
        });
      });
      setState(() {
        potStatus = getStatus(potList);
        materialStatus = getStatus(materialList);
        acceList.forEach((element) {
          element['checkStatus'] = getStatus(element['child']);
        });
        acceStatus = getStatus(acceList);
        setFloatingActionButtonFlag(_tabIndex);
      });
      if (type) $successToast(context, msg: '操作成功');
    } catch (e) {}
  }

  List _acceData(List data) {
    var listData = [];
    data.asMap().keys.forEach((index) {
      if (index > 0 &&
          data[index]['useMaterialCode'] ==
              data[index - 1]['useMaterialCode']) {
        listData[listData.length - 1]['child'].add(data[index]);
      } else {
        listData.add({
          'useMaterialCode': data[index]['useMaterialCode'],
          'useMaterialName': data[index]['useMaterialName'],
          'useMaterialType': data[index]['useMaterialType'],
          'useUnit': data[index]['useUnit'],
          'child': [data[index]],
        });
      }
    });
    return listData;
  }

  _submitPage() async {
    String type = '';
    if (_tabIndex == 0) {
      type = 'cooking';
    }
    if (_tabIndex == 1) {
      type = 'accessories';
    }
    if (_tabIndex == 2) {
      type = 'new';
    }
    try {
      await Sterilize.acceAddSubmitApi({
        'potOrderNo': widget.arguments['potNum']['potNo'],
        'steCookingConsumeFlag': steCookingConsumeFlag,
        'type': type,
      });
      _initState(type: true);
      setState(() {});
    } catch (e) {}
  }

  _delPot(index) async {
    try {
      await Sterilize.acceAddPotDelApi({
        'ids': [potList[index]['id']],
        'potOrderNo': widget.arguments['potNum']['potNo'],
      });
      $successToast(context, msg: '操作成功');
      potList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  _delAcceReceive(index, childIndex) async {
    if (acceList[index]['child'][childIndex]['splitFlag'] != 'Y') {
      EasyLoading.showError('不能删除哦');
      return;
    }
    try {
      await Sterilize.acceAddAcceReceiveDelApi({
        'ids': [acceList[index]['child'][childIndex]['id']],
        'potOrderNo': widget.arguments['potNum']['potNo'],
      });
      $successToast(context, msg: '操作成功');
      acceList[index]['child'].removeAt(childIndex);
      setState(() {});
    } catch (e) {}
  }

  _delMaterial(index) async {
    try {
      await Sterilize.acceAddMaterialDelApi({
        'ids': [materialList[index]['id']],
        'potOrderNo': widget.arguments['potNum']['potNo'],
      });
      $successToast(context, msg: '操作成功');
      materialList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  _getBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
          child: _floatingActionButtonFlag
              ? FloatingActionButton(
                  onPressed: () {
                    if (_tabIndex == 0) {
                      if (steCookingConsumeFlag == '1') {
                        Navigator.pushNamed(
                          context,
                          '/sterilize/acceAdd/potAdd',
                          arguments: {
                            'potOrderNo': widget.arguments['potNum']['potNo'],
                            'potOrderId': widget.arguments['potNum']
                                ['potOrderId'],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      } else {}
                    } else {
                      print(widget.arguments['potNum']);
                      Navigator.pushNamed(
                        context,
                        '/sterilize/acceAdd/materialAdd',
                        arguments: {
                          'potOrderNo': widget.arguments['potNum']['potNo'],
                          'potOrderId': widget.arguments['potNum']
                              ['potOrderId'],
                        },
                      ).then((value) => value != null ? _initState() : null);
                    }
                  },
                  child: Icon(Icons.add),
                )
              : SizedBox(),
        ),
        (_tabIndex == 0 && potStatus) ||
                (_tabIndex == 1 && acceStatus) ||
                (_tabIndex == 2 && materialStatus)
            ? Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: MdsWidthButton(
                  text: '提交',
                  onPressed: _submitPage,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: '辅料添加', refresh: true),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
          tabChange: setFloatingActionButtonFlag,
          children: <Widget>[
            SizedBox(height: 5),
            PageHead(
              title:
                  '${widget.arguments['potName']} 第${widget.arguments['potNum']['potOrder']}锅',
              subTitle: '${widget.arguments['potNum']['materialName']}',
              orderNo: '${widget.arguments['potNum']['orderNo']}',
              potNo: '${widget.arguments['potNum']['potNo']}',
            ),
            SizedBox(height: 5),
          ],
          tabBarChildren: <Widget>[
            Tab(text: '煮料锅'),
            Tab(text: '辅料领用'),
            Tab(text: '增补料'),
          ],
          tabBarViewChildren: <Widget>[
            PotListWidget(
              data: potList,
              updataFn: _initState,
              arguments: {
                'potOrderNo': widget.arguments['potNum']['potNo'],
                'potOrderId': widget.arguments['potNum']['potOrderId'],
              },
              delFn: _delPot,
            ),
            AcceReceiveTab(
              data: acceList,
              updataFn: _initState,
              arguments: {
                'statusName': widget.arguments['statusName'],
                'potOrderNo': widget.arguments['potNum']['potNo'],
                'potOrderId': widget.arguments['potNum']['potOrderId'],
              },
              delFn: _delAcceReceive,
            ),
            MaterialAddTab(
              data: materialList,
              updataFn: _initState,
              arguments: {
                'potOrderNo': widget.arguments['potNum']['potNo'],
                'potOrderId': widget.arguments['potNum']['potOrderId'],
              },
              delFn: _delMaterial,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          height: 130,
          child: _getBtn(),
        ),
      ),
    );
  }
}

// 煮料锅tab
class PotListWidget extends StatefulWidget {
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;
  PotListWidget({Key key, this.arguments, this.data, this.updataFn, this.delFn})
      : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget>
    with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '', 'value': 'potNoName'},
    {'label': '', 'value': 'cookingNumName'},
    {'label': '', 'value': 'transferTank'},
    {'label': '', 'value': 'cookingMaterialName'},
    {'label': '', 'value': 'cookingOrderNo'},
    {'label': '配置日期：', 'value': 'configDate'},
    {'label': '添加时间', 'value': 'addDate'},
    {'label': '剩余库存', 'value': 'remainderAmount'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
    {'label': '备注：', 'value': 'remark'},
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.data.length != 0
        ? ListView.builder(
            padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              bool submitButtonFlag = true;
              if (!(widget.data[index]['checkStatus'] == 'N' ||
                  widget.data[index]['checkStatus'] == 'R' ||
                  widget.data[index]['checkStatus'] == 'S' ||
                  widget.data[index]['checkStatus'] == 'T' ||
                  widget.data[index]['checkStatus'] == '')) {
                submitButtonFlag = false;
              }
              return SlideButton(
                index: index,
                singleButtonWidth: 70,
                child: ItemCard(
                  submitButtonFlag: submitButtonFlag,
                  carTitle: '煮料锅领用数量',
                  cardMap: widget.data[index],
                  title: 'consumeAmount',
                  subTitle: 'unit',
                  wrapList: wrapList,
                  onTap: () {
                    if (!(widget.data[index]['checkStatus'] == 'N' ||
                        widget.data[index]['checkStatus'] == 'R' ||
                        widget.data[index]['checkStatus'] == 'S' ||
                        widget.data[index]['checkStatus'] == 'T' ||
                        widget.data[index]['checkStatus'] == '')) {
                      return;
                    }
                    Navigator.pushNamed(
                      context,
                      '/sterilize/acceAdd/potAdd',
                      arguments: {
                        'potOrderNo': widget.arguments['potOrderNo'],
                        'potOrderId': widget.arguments['potOrderId'],
                        'data': widget.data[index],
                      },
                    ).then((value) => value != null ? widget.updataFn() : null);
                  },
                ),
                buttons: <Widget>[
                  CardRemoveBtn(
                    removeOnTab: () {
                      if (!(widget.data[index]['checkStatus'] == 'N' ||
                          widget.data[index]['checkStatus'] == 'R' ||
                          widget.data[index]['checkStatus'] == 'S' ||
                          widget.data[index]['checkStatus'] == 'T' ||
                          widget.data[index]['checkStatus'] == '')) {
                        return;
                      }
                      widget.delFn(index);
                    },
                  ),
                ],
              );
            },
          )
        : NoDataWidget();
  }

  @override
  bool get wantKeepAlive => true;
}

// 辅料领用tab
class AcceReceiveTab extends StatefulWidget {
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;

  AcceReceiveTab(
      {Key key, this.arguments, this.data, this.updataFn, this.delFn})
      : super(key: key);

  @override
  _AcceReceiveTabState createState() => _AcceReceiveTabState();
}

class _AcceReceiveTabState extends State<AcceReceiveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.data.length != 0
        ? ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              bool submitButtonFlag = true;
              if (!widget.data[index]['checkStatus']) {
                submitButtonFlag = false;
              }

              List<Widget> childList = [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: ColumnItem(
                    addFlag: true,
                    btnFlag: submitButtonFlag,
                    startText: widget.data[index]['useMaterialCode'],
                    endText: widget.data[index]['useMaterialName'],
                    onTap: () {
                      if (!widget.data[index]['checkStatus']) {
                        return;
                      }
                      Navigator.pushNamed(
                        context,
                        '/sterilize/acceAdd/acceReceive',
                        arguments: {
                          'potOrderNo': widget.arguments['potOrderNo'],
                          'potOrderId': widget.arguments['potOrderId'],
                          'useMaterialCode': widget.data[index]
                              ['useMaterialCode'],
                          'useMaterialName': widget.data[index]
                              ['useMaterialName'],
                          'useMaterialType': widget.data[index]
                              ['useMaterialType'],
                          'useUnit': widget.data[index]['useUnit'],
                        },
                      ).then(
                          (value) => value != null ? widget.updataFn() : null);
                    },
                  ),
                ),
              ];
              widget.data[index]['child'].asMap().keys.forEach((childIndex) {
                bool childSubmitButtonFlag = true;
                if (!(widget.data[index]['child'][childIndex]['checkStatus'] ==
                        'N' ||
                    widget.data[index]['child'][childIndex]['checkStatus'] ==
                        'R' ||
                    widget.data[index]['child'][childIndex]['checkStatus'] ==
                        'S' ||
                    widget.data[index]['child'][childIndex]['checkStatus'] ==
                        'T' ||
                    widget.data[index]['child'][childIndex]['checkStatus'] ==
                        '')) {
                  childSubmitButtonFlag = false;
                }
                childList.add(Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: SlideButton(
                      index: index,
                      child: ColumnItem(
                        btnFlag: childSubmitButtonFlag,
                        startText: widget.data[index]['child'][childIndex]
                                    ['useAmount'] ==
                                null
                            ? ''
                            : widget.data[index]['child'][childIndex]
                                        ['useAmount']
                                    .toString() +
                                widget.data[index]['child'][childIndex]
                                    ['useUnit'],
                        centerText: widget.data[index]['child'][childIndex]
                            ['useBatch'],
                        onTap: () {
                          if (!(widget.data[index]['child'][childIndex]
                                      ['checkStatus'] ==
                                  'N' ||
                              widget.data[index]['child'][childIndex]
                                      ['checkStatus'] ==
                                  'R' ||
                              widget.data[index]['child'][childIndex]
                                      ['checkStatus'] ==
                                  'S' ||
                              widget.data[index]['child'][childIndex]
                                      ['checkStatus'] ==
                                  'T' ||
                              widget.data[index]['child'][childIndex]
                                      ['checkStatus'] ==
                                  '')) {
                            return;
                          }
                          Navigator.pushNamed(
                            context,
                            '/sterilize/acceAdd/acceReceive',
                            arguments: {
                              'potOrderNo': widget.arguments['potOrderNo'],
                              'potOrderId': widget.arguments['potOrderId'],
                              'useMaterialCode': widget.data[index]
                                  ['useMaterialCode'],
                              'useMaterialName': widget.data[index]
                                  ['useMaterialName'],
                              'useMaterialType': widget.data[index]
                                  ['useMaterialType'],
                              'useUnit': widget.data[index]['useUnit'],
                              'data': widget.data[index]['child'][childIndex],
                            },
                          ).then((value) =>
                              value != null ? widget.updataFn() : null);
                        },
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
                                child: Icon(
                                    IconData(0xe674, fontFamily: 'MdsIcon'),
                                    color: Colors.white,
                                    size: 16),
                                onPressed: () {
                                  if (!(widget.data[index]['child'][childIndex]
                                              ['checkStatus'] ==
                                          'N' ||
                                      widget.data[index]['child'][childIndex]
                                              ['checkStatus'] ==
                                          'R' ||
                                      widget.data[index]['child'][childIndex]
                                              ['checkStatus'] ==
                                          'S' ||
                                      widget.data[index]['child'][childIndex]
                                              ['checkStatus'] ==
                                          'T' ||
                                      widget.data[index]['child'][childIndex]
                                              ['checkStatus'] ==
                                          '')) {
                                    return;
                                  }
                                  widget.delFn(index, childIndex);
                                },
                              ),
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
          )
        : NoDataWidget();
  }

  @override
  bool get wantKeepAlive => true;
}

// 辅料单item
class ColumnItem extends StatefulWidget {
  final bool addFlag;
  final bool btnFlag;
  final String startText;
  final String centerText;
  final String endText;
  final Function onTap;
  ColumnItem(
      {Key key,
      this.addFlag = false,
      this.btnFlag = true,
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
          widget.btnFlag
              ? widget.addFlag == true
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
                        size: 15,
                        color: Color(0xFF487BFF),
                      ),
                      onTap: widget.onTap,
                    )
              : SizedBox(),
        ],
      ),
    );
  }
}

// 增补料tab
class MaterialAddTab extends StatefulWidget {
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;
  MaterialAddTab(
      {Key key, this.arguments, this.data, this.updataFn, this.delFn})
      : super(key: key);

  @override
  _MaterialAddTabState createState() => _MaterialAddTabState();
}

class _MaterialAddTabState extends State<MaterialAddTab>
    with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '', 'value': 'useMaterialName'},
    {'label': '', 'value': 'useBatch'},
    {'label': '添加时间', 'value': 'addDate'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
    {'label': '备注：', 'value': 'remark'},
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.data.length != 0
        ? ListView.builder(
            padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              bool submitButtonFlag = true;
              if (!(widget.data[index]['checkStatus'] == 'N' ||
                  widget.data[index]['checkStatus'] == 'R' ||
                  widget.data[index]['checkStatus'] == 'S' ||
                  widget.data[index]['checkStatus'] == 'T' ||
                  widget.data[index]['checkStatus'] == '')) {
                submitButtonFlag = false;
              }
              return SlideButton(
                index: index,
                singleButtonWidth: 70,
                child: ItemCard(
                  submitButtonFlag: submitButtonFlag,
                  carTitle: '增补料领用数量',
                  cardMap: widget.data[index],
                  title: 'useAmount',
                  subTitle: 'useUnit',
                  wrapList: wrapList,
                  onTap: () {
                    if (!(widget.data[index]['checkStatus'] == 'N' ||
                        widget.data[index]['checkStatus'] == 'R' ||
                        widget.data[index]['checkStatus'] == 'S' ||
                        widget.data[index]['checkStatus'] == 'T' ||
                        widget.data[index]['checkStatus'] == '')) {
                      return;
                    }
                    Navigator.pushNamed(
                      context,
                      '/sterilize/acceAdd/materialAdd',
                      arguments: {
                        'potOrderNo': widget.arguments['potOrderNo'],
                        'potOrderId': widget.arguments['potOrderId'],
                        'data': widget.data[index],
                      },
                    ).then((value) => value != null ? widget.updataFn() : null);
                  },
                ),
                buttons: <Widget>[
                  CardRemoveBtn(
                    removeOnTab: () {
                      if (!(widget.data[index]['checkStatus'] == 'N' ||
                          widget.data[index]['checkStatus'] == 'R' ||
                          widget.data[index]['checkStatus'] == 'S' ||
                          widget.data[index]['checkStatus'] == 'T' ||
                          widget.data[index]['checkStatus'] == '')) {
                        return;
                      }
                      widget.delFn(index);
                    },
                  ),
                ],
              );
            },
          )
        : NoDataWidget();
  }

  @override
  bool get wantKeepAlive => true;
}
