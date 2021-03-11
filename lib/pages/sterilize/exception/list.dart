import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import '../common/page_head.dart';
import 'package:dfmdsapp/api/api/index.dart';
import '../common/exception_card.dart';
import '../../../components/remove_btn.dart';
import 'package:dfmdsapp/components/toast.dart';
import '../common/text_card.dart';
import 'package:dfmdsapp/utils/storage.dart';

class ExceptionList extends StatefulWidget {
  final arguments;
  ExceptionList({Key key, this.arguments}) : super(key: key);

  @override
  _ExceptionListState createState() => _ExceptionListState();
}

class _ExceptionListState extends State<ExceptionList> {
  bool _floatingActionButtonFlag = true;
  int _tabIndex = 0;
  List exceptionList = []; // 异常列表
  List textList = []; // 文本列表

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

  _initState() async {
    var workShopId = await SharedUtil.instance.getStorage('workShopId');
    try {
      // 异常列表
      var res = await Sterilize.sterilizeExceptionDetailListApi({
        "potOrderNo": widget.arguments['potDetail']['potNo'],
        "potOrderId": widget.arguments['potDetail']['potOrderId'],
        "orderId": widget.arguments['potDetail']['orderId'],
        "orderNo": widget.arguments['potDetail']['orderNo'],
        "exceptionStage": widget.arguments['typeCode'],
        "workShop": workShopId
      });
      this.exceptionList = res['data'];
      // 文本列表
      var testRes = await Sterilize.sterilizeExceptionDetailTextApi({
        "potOrderNo": widget.arguments['potDetail']['potNo'],
        "potOrderId": widget.arguments['potDetail']['potOrderId'],
        "orderId": widget.arguments['potDetail']['orderId'],
        "orderNo": widget.arguments['potDetail']['orderNo'],
        "textStage": widget.arguments['typeCode'],
      });
      if (testRes['data'] != null) {
        this.textList = [testRes['data']];
      }
      _floatingActionButtonFlag = this._isButtonFlag(_tabIndex);
      setState(() {}); //
    } catch (e) {}
  }

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    _floatingActionButtonFlag = this._isButtonFlag(index);
    _tabIndex = index;
    setState(() {});
  }

  // 是否显示加号
  _isButtonFlag(int tabIndex) {
    bool buttonFlag = true;
    if (tabIndex == 1) {
      buttonFlag = this.textList.length == 1 ? false : true;
    } else {
      buttonFlag = true;
    }
    return buttonFlag;
  }

  // 异常删除
  _delPot(index) async {
    try {
      await Sterilize.sterilizeExceptionDetailDeleteApi(
          [this.exceptionList[index]['id']]);
      $successToast(context, msg: '操作成功');
      this.exceptionList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: '${widget.arguments['barTitle']}'),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
            tabChange: setFloatingActionButtonFlag,
            children: <Widget>[
              SizedBox(height: 5),
              PageHead(
                title:
                    '${widget.arguments['potDetail']['potName']} 第${widget.arguments['potDetail']['potOrder']}锅',
                subTitle: '${widget.arguments['potDetail']['materialName']}',
                orderNo: '${widget.arguments['potDetail']['orderNo']}',
                potNo: '${widget.arguments['potDetail']['potNo']}',
              ),
              SizedBox(height: 5),
            ],
            tabBarChildren: <Widget>[
              Tab(text: '异常记录'),
              Tab(text: '其他记录'),
            ],
            tabBarViewChildren: <Widget>[
              DateListWidget(
                data: this.exceptionList,
                updataFn: _initState,
                arguments: {
                  'typeCode': widget.arguments['typeCode'],
                  'potDetail': widget.arguments['potDetail'],
                },
                delFn: _delPot,
              ),
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
                  itemCount: this.textList.length,
                  itemBuilder: (context, index) {
                    return TextCard(
                      dataList: this.textList,
                      text: 'text',
                      idx: index,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/sterilize/exception/textAdd',
                          arguments: {
                            'typeCode': widget.arguments['typeCode'],
                            'potDetail': widget.arguments['potDetail'],
                            'data': this.textList[index],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      },
                    );
                  })
            ]),
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
                              context,
                              '/sterilize/exception/add',
                              arguments: {
                                'typeCode': widget.arguments['typeCode'],
                                'potDetail': widget.arguments['potDetail'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          } else {
                            Navigator.pushNamed(
                              context,
                              '/sterilize/exception/textAdd',
                              arguments: {
                                'typeCode': widget.arguments['typeCode'],
                                'potDetail': widget.arguments['potDetail'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          }
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 异常list
class DateListWidget extends StatefulWidget {
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;
  DateListWidget(
      {Key key, this.arguments, this.data, this.updataFn, this.delFn})
      : super(key: key);

  @override
  _DateListWidgetState createState() => _DateListWidgetState();
}

class _DateListWidgetState extends State<DateListWidget>
    with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '班次：', 'value': 'classesName'},
    {'label': '异常情况：', 'value': 'exceptionSituationName'},
    {'label': '异常原因：', 'value': 'exceptionReasonName'},
    {'label': '异常描述：', 'value': 'exceptionInfo'},
    {'label': '备注：', 'value': 'remark'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return SlideButton(
          index: index,
          singleButtonWidth: 70,
          child: ExceptionItemCard(
            idx: index,
            startTime: 'startDate',
            endTime: 'endDate',
            cardMap: widget.data[index],
            wrapList: wrapList,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/sterilize/exception/add',
                arguments: {
                  'typeCode': widget.arguments['typeCode'],
                  'potDetail': widget.arguments['potDetail'],
                  'data': widget.data[index],
                },
              ).then((value) => value != null ? widget.updataFn() : null);
            },
          ),
          buttons: <Widget>[
            CardRemoveBtn(
              removeOnTab: () => widget.delFn(index),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
