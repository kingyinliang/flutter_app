import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import 'package:dfmdsapp/components/sliver_tab_bar.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import '../common/page_head.dart';
import 'package:dfmdsapp/api/api/index.dart';
import '../common/exception_card.dart';
import '../common/remove_btn.dart';
import 'package:dfmdsapp/utils/toast.dart';

class CraftExceptionList extends StatefulWidget {
  final arguments;
  CraftExceptionList({Key key, this.arguments}) : super(key: key);

  @override
  _CraftExceptionListState createState() => _CraftExceptionListState();
}

class _CraftExceptionListState extends State<CraftExceptionList> {
  var steCookingConsumeFlag;
  bool _floatingActionButtonFlag = true;
  int _tabIndex = 0;
  List materialInfo = [];
  List potList = [];

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    _tabIndex = index;
    setState(() {});
  }

  Future<List> getcontrolTypeName(String val) async {
    var res = await Common.dictDropDownQuery({'dictType': val});
    return res['data'];
  }

  _initState() async {
    try {
      var res = await Sterilize.sterilizeCraftMaterialListApi({
        "potOrderNo": widget.arguments['potDetail']['potNo']
      });
      if (res['data'] != null ) {
        materialInfo = [res['data']];
        print('123456789');
        print(materialInfo);
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
        potList = res['data']['item'];
      }
      _floatingActionButtonFlag = true;
      setState(() {});
    } catch (e) {}
  }

  // 加号是否显示  type （0加号  1提交）
  getFloatingActionButtonFlag(int index, List data, int type) {
    bool ButtonFlag = true;
    if (index == 0) {
      if (type == 1) {
        ButtonFlag = data[0]['checkStatus'] == 'M' ? false : true;
      } else {
        ButtonFlag = (materialInfo.length == 1 || data[0]['checkStatus'] == 'M') ? false : true;
      }
    } else {
      if (data[0]['item'].length == 0) {
        ButtonFlag = true;
      } else if (data[0]['item'][0]['checkStatus'] == 'M') {
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
      successToast(msg: '操作成功');
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
    }
    try {
      await Sterilize.sterilizeCraftMaterialTimeSubmitApi({
        'potOrderNo': widget.arguments['potDetail']['potNo'],
        'type': type,
      });
      _initState();
      successToast(msg: '操作成功');
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
              title: '110#锅 第${widget.arguments['potDetail']['potOrder']}锅',
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
            PotListWidget(
              data: potList,
              updataFn: _initState,
              arguments: {
                'potOrderNo': widget.arguments['potDetail']['potNo'],
                'potOrderId': widget.arguments['potDetail']['potOrderId'],
              },
              delFn: _delPot,
              submitButtonFlag: true
            ),
            PotListWidget(
                data: potList,
                updataFn: _initState,
                arguments: {
                  'potOrderNo': widget.arguments['potDetail']['potNo'],
                  'potOrderId': widget.arguments['potDetail']['potOrderId'],
                },
                delFn: _delPot,
                submitButtonFlag: true
            )
          ]
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
                child: _floatingActionButtonFlag ?
                  FloatingActionButton(
                    onPressed: () {
                      if (_tabIndex == 0) {
                        Navigator.pushNamed(
                          context,
                          '/sterilize/exception/add',
                          arguments: {
                            'potOrderNo': widget.arguments['potDetail']['potNo'],
                            'potOrderId': widget.arguments['potDetail']['potOrderId'],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/sterilize/exception/textAdd',
                          arguments: {
                            'potOrderNo': widget.arguments['potDetail']['potNo'],
                            'potOrderId': widget.arguments['potDetail']['potOrderId'],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      }
                    },
                    child: Icon(Icons.add),
                  ) : SizedBox(),
              )
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
  PotListWidget({Key key, this.arguments, this.data, this.updataFn, this.delFn, this.submitButtonFlag}) : super(key: key);

  @override
  _PotListWidgetState createState() => _PotListWidgetState();
}

class _PotListWidgetState extends State<PotListWidget>
with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '类型：', 'value': 'controlTypeName'},
    {'label': '阶段：', 'value': 'controlStage'},
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
                '/sterilize/exception/add',
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
