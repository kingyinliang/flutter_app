import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import '../common/page_head.dart';
import 'package:dfmdsapp/api/api/index.dart';
import '../common/item_card.dart';
import '../../../components/remove_btn.dart';
import 'package:dfmdsapp/utils/toast.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/toast.dart';

class CraftList extends StatefulWidget {
  final arguments;
  CraftList({Key key, this.arguments}) : super(key: key);

  @override
  _CraftListState createState() => _CraftListState();
}

class _CraftListState extends State<CraftList> {
  var steCookingConsumeFlag;
  bool _floatingActionButtonFlag = true;
  bool _submitButtonFlag = true;
  int _tabIndex = 0;
  List materialInfo = [];
  List potList = [];
  Map StageList = new Map(); // 阶段list

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
//    if (materialInfo.length == 0) {
//      _floatingActionButtonFlag = true;
//      _submitButtonFlag = true;
//    } else {
    _floatingActionButtonFlag =
        getFloatingActionButtonFlag(index, 0, materialInfo, potList);
    _submitButtonFlag =
        getFloatingActionButtonFlag(index, 1, materialInfo, potList);
//    }
    _tabIndex = index;
    setState(() {});
  }

  Future<List> getcontrolTypeName(String val) async {
    var res = await Common.dictDropDownQuery({'dictType': val});
    return res['data'];
  }

  _initState() async {
    var res1 = await Common.getDictDropAll(['COOL', 'HEAT', 'DISCHARGE']);
    this.StageList = res1['data'];
    var res = await Sterilize.sterilizeCraftMaterialListApi(
        {"potOrderNo": widget.arguments['potNum']['potNo']});
    setState(() {
      // 入料&升温
      if (res['data']['id'] == '') {
        materialInfo = [];
      } else {
        materialInfo = [res['data']];
        if (res['data']['keepZkFlag'] == 'Y') {
          materialInfo[0]['keepZkFlagString'] = '是';
        } else {
          materialInfo[0]['keepZkFlagString'] = '否';
        }
        if (res['data']['coolZkFlag'] == 'Y') {
          materialInfo[0]['coolZkFlagString'] = '是';
        } else {
          materialInfo[0]['coolZkFlagString'] = '否';
        }
      }
      // 时间&温度
      potList = res['data']['item'];
      for (int i = 0; i < potList.length; i++) {
        var testFirstWhere = this
            .StageList[potList[i]['controlType']]
            .firstWhere(
                (item) => item["dictCode"] == potList[i]['controlStage']);
        potList[i]['controlStageName'] = testFirstWhere['dictValue'];
      }
      _floatingActionButtonFlag =
          getFloatingActionButtonFlag(_tabIndex, 0, materialInfo, potList);
      _submitButtonFlag =
          getFloatingActionButtonFlag(_tabIndex, 1, materialInfo, potList);
    });
  }

  // 加号是否显示  index( 0入料&升温  1杀菌时间 ) type （0加号  1提交）
  getFloatingActionButtonFlag(int index, int type, List data, List potData) {
    bool ButtonFlag = true;
    if (index == 0) {
      if (data.length == 0) {
        ButtonFlag = true;
      } else {
        if (type == 1) {
          ButtonFlag = data[0]['checkStatus'] == 'D' ? false : true;
        } else {
          ButtonFlag =
              (materialInfo.length == 1 || data[0]['checkStatus'] == 'D')
                  ? false
                  : true;
        }
      }
    } else {
      if (potData.length == 0) {
        ButtonFlag = true;
      } else if (potData[0]['checkStatus'] == 'D') {
        ButtonFlag = false;
      } else {
        ButtonFlag = true;
      }
    }
    return ButtonFlag;
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

  _delPot(index) async {
    try {
      await Sterilize.sterilizeCraftMaterialTimeDelApi([potList[index]['id']]);
      $successToast(context, msg: '操作成功');
      potList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  // 提交
  _submitPage() async {
    String type = '';
    if (_tabIndex == 0) {
      type = '1';
    }
    if (_tabIndex == 1) {
      type = '2';
      int isStage = 0;
      if (potList.length == 0) {
        errorToast(msg: '请填写杀菌时间&温度');
        return;
      } else {
        for (int i = 0; i < potList.length; i++) {
          if (potList[i]['controlStage'] == 'HEAT_START' ||
              potList[i]['controlStage'] == 'HEAT_END' ||
              potList[i]['controlStage'] == 'DISCHARGE_START' ||
              potList[i]['controlStage'] == 'DISCHARGE_END') {
            isStage++;
          }
        }
        if (isStage < 4) {
          errorToast(msg: '请填写保温开始时间、保温结束时间、出料开始时间、出料结束时间');
          return;
        }
      }
    }
    try {
      await Sterilize.sterilizeCraftMaterialTimeSubmitApi({
        'potOrderNo': widget.arguments['potNum']['potNo'],
        'type': type,
      });
      _initState();
      $successToast(context, msg: '操作成功');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: '工艺控制'),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
            tabChange: setFloatingActionButtonFlag,
            children: <Widget>[
              SizedBox(height: 5),
              PageHead(
                title:
                    '${widget.arguments['potNum']['potName']} 第${widget.arguments['potNum']['potOrder']}锅',
                subTitle: '${widget.arguments['potNum']['materialName']}',
                orderNo: '${widget.arguments['potNum']['orderNo']}',
                potNo: '${widget.arguments['potNum']['potNo']}',
              ),
              SizedBox(height: 5),
            ],
            tabBarChildren: <Widget>[
              Tab(text: '入料&升温'),
              Tab(text: '杀菌时间&温度'),
            ],
            tabBarViewChildren: <Widget>[
              ListView.builder(
                  itemCount: materialInfo.length,
                  itemBuilder: (context, idx) {
                    return Container(
                      padding: EdgeInsets.all(5),
//                  margin: EdgeInsets.only(bottom: 6.0),
                      child: Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('入料时间',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Expanded(
                                      child: Text(''), // 中间用Expanded控件
                                    ),
                                    InkWell(
                                      child: _submitButtonFlag
                                          ? Icon(
                                              IconData(0xe62c,
                                                  fontFamily: 'MdsIcon'),
                                              size: 16.0,
                                              color: Color(0xFF487BFF),
                                            )
                                          : SizedBox(),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/sterilize/craft/materialAdd',
                                          arguments: {
                                            'potOrderNo':
                                                widget.arguments['potOrderNo'],
                                            'potOrderId':
                                                widget.arguments['potOrderId'],
                                            'data': materialInfo[idx],
                                          },
                                        ).then((value) => value != null
                                            ? _initState()
                                            : null);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    Text('开始时间'),
                                    Expanded(
                                      child: Text(''),
                                    ),
                                    Text('结束时间')
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                        '${materialInfo[idx]['feedStartDate'] == null ? '' : materialInfo[idx]['feedStartDate']}',
                                        style: TextStyle(fontSize: 14)),
                                    Expanded(
                                      child: Text(''),
                                    ),
                                    Text(
                                        '${materialInfo[idx]['feeEndDate'] == null ? '' : materialInfo[idx]['feeEndDate']}',
                                        style: TextStyle(fontSize: 14))
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    Text('入料时间',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Expanded(
                                      child: Text(''), // 中间用Expanded控件
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    Text('开始时间'),
                                    Expanded(
                                      child: Text(''),
                                    ),
                                    Text('结束时间')
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                        '${materialInfo[idx]['riseStartDate'] == null ? '' : materialInfo[idx]['riseStartDate']}',
                                        style: TextStyle(fontSize: 14)),
                                    Expanded(
                                      child: Text(''),
                                    ),
                                    Text(
                                        '${materialInfo[idx]['riseEndDate'] == null ? '' : materialInfo[idx]['riseEndDate']}',
                                        style: TextStyle(fontSize: 14))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 3, 12, 3),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF8D0CB),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17))),
                                      child: Text(
                                          '保温阶段-ZK：${materialInfo[idx]['keepZkFlagString']}'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      padding:
                                          EdgeInsets.fromLTRB(12, 3, 12, 3),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFCEBB9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17))),
                                      child: Text(
                                          '降温阶段-ZK：${materialInfo[idx]['coolZkFlagString']}'),
                                    ),
                                  ],
                                ),
                              ]))),
                    );
                  }),
              PotListWidget(
                  data: potList,
                  updataFn: _initState,
                  arguments: {
                    'potOrderNo': widget.arguments['potNum']['potNo'],
                    'potOrderId': widget.arguments['potNum']['potOrderId'],
                    'materialCode': widget.arguments['potNum']['materialCode'],
                  },
                  delFn: _delPot,
                  submitButtonFlag: _submitButtonFlag),
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
                              '/sterilize/craft/materialAdd',
                              arguments: {
                                'potOrderNo': widget.arguments['potNum']
                                    ['potNo'],
                                'potOrderId': widget.arguments['potNum']
                                    ['potOrderId'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          } else {
                            Navigator.pushNamed(
                              context,
                              '/sterilize/craft/timeAdd',
                              arguments: {
                                'craftInfo': materialInfo.length > 0
                                    ? materialInfo[0]
                                    : {},
                                'isFirst': potList.length > 0 ? false : true,
                                'potOrderNo': widget.arguments['potNum']
                                    ['potNo'],
                                'materialCode': widget.arguments['potNum']
                                    ['materialCode'],
                                'potOrderId': widget.arguments['potNum']
                                    ['potOrderId'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          }
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: _submitButtonFlag
                    ? MdsWidthButton(
                        text: '提交',
                        onPressed: _submitPage,
                      )
                    : SizedBox(),
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
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;
  final bool submitButtonFlag;
  PotListWidget(
      {Key key,
      this.arguments,
      this.data,
      this.updataFn,
      this.delFn,
      this.submitButtonFlag})
      : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget>
    with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '类型：', 'value': 'controlTypeName'},
    {'label': '阶段：', 'value': 'controlStageName'},
    {'label': '记录时间：', 'value': 'recordDate'},
    {'label': '', 'value': 'cookingOrderNo'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
    {'label': '备注：', 'value': 'remark'},
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
          child: ItemCard(
            submitButtonFlag: widget.submitButtonFlag,
            carTitle: '温度(℃)',
            cardMap: widget.data[index],
            title: 'temp',
            wrapList: wrapList,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/sterilize/craft/timeAdd',
                arguments: {
                  'potOrderNo': widget.arguments['potOrderNo'],
                  'potOrderId': widget.arguments['potOrderId'],
                  'materialCode': widget.arguments['materialCode'],
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
