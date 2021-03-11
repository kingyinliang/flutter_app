import 'package:dfmdsapp/utils/index.dart';

class SteamLookRecordPage extends StatefulWidget {
  final arguments;
  SteamLookRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamLookRecordPageState createState() => _SteamLookRecordPageState();
}

class _SteamLookRecordPageState extends State<SteamLookRecordPage> {
  List pageData = [{}, {}];
  List listData = [];
  String exception = '';
  String status = '';
  String statusName = '';

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

  _initState() async {
    try {
      // 页签状态
      var res = await KojiMaking.kojiMakingOrder({
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "dataType": "DISC_GUARD"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      // 看曲记录
      var res = await KojiMaking.discLookQuery(
          {"kojiOrderNo": widget.arguments['data']['kojiOrderNo']});
      listData = res['data'];
//      listData = MapUtil.listNullToEmpty(listData);
      setState(() {});
    } catch (e) {}
    try {
      // 看曲异常情况记录
      var res2 = await KojiMaking.discLookExceptQuery(
          {"kojiOrderNo": widget.arguments['data']['kojiOrderNo']});
      if (res2['data'] != null) {
        exception = res2['data'];
      }
      setState(() {});
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.discLookDel({'id': listData[index]['id']});
      $successToast(context, msg: '操作成功');
      listData.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    if (listData.length > 0) {
      for (Map planet in listData) {
        if (planet['windTemp'] == null || planet['windTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 实际风温');
          return;
        }
        if (planet['roomTemp'] == null || planet['roomTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 下室温度');
          return;
        }
        if (planet['prodTemp'] == null || planet['prodTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 品温');
          return;
        }
        if (planet['outUpTemp'] == null || planet['outUpTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 外上温度');
          return;
        }
        if (planet['outMidTemp'] == null || planet['outMidTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 外中温度');
          return;
        }
        if (planet['outDownTemp'] == null || planet['outDownTemp'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 外下温度');
          return;
        }
        if (planet['windDoor'] == null || planet['windDoor'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 风门开度');
          return;
        }
        if (planet['forceDrain'] == null || planet['forceDrain'] == '') {
          EasyLoading.showError('请选择 `${planet['guardDate']}` 强排设备');
          return;
        }
        if (planet['changeHot'] == null || planet['changeHot'] == '') {
          EasyLoading.showError('请选择 `${planet['guardDate']}` 换热设备');
          return;
        }
        if (planet['windSpeed'] == null || planet['windSpeed'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 风速');
          return;
        }
        if (planet['testTempOne'] == null || planet['testTempOne'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 测量温度1');
          return;
        }
        if (planet['testTempTwo'] == null || planet['testTempTwo'] == '') {
          EasyLoading.showError('请填写 `${planet['guardDate']}` 测量温度2');
          return;
        }
      }
      try {
        await KojiMaking.discLookSubmit({
          'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
        });
        await $successToast(context, msg: '操作成功');
        _initState();
      } catch (e) {}
    } else {
      EasyLoading.showError('请先添加看曲数据');
    }
  }

  Widget _listWidget(index) {
    if (index == 0) {
      return Column(
        children: _getList(),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(12, 10, 14, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '异常情况',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ),
                  (status == 'N' ||
                          status == 'R' ||
                          status == 'S' ||
                          status == 'T' ||
                          status == '')
                      ? InkWell(
                          child: Icon(
                            IconData(0xe62c, fontFamily: 'MdsIcon'),
                            size: 14,
                            color: Color(0xFF487BFF),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/kojiMaking/steamLookRecordAdd',
                              arguments: {
                                'data': {'remark': exception},
                                'orderNo': widget.arguments['data']['orderNo'],
                                'kojiOrderNo': widget.arguments['data']
                                    ['kojiOrderNo'],
                                'onType': 'exception'
                              },
                            ).then((value) =>
                                value != null ? _initState() : _initState());
                          },
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 10),
              Text(
                exception,
                style: TextStyle(color: Color(0xFF333333), fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<Widget> _getList() {
    List<Widget> widgetList = [
      Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: ColumnItem(
          addFlag: true,
          startText: '看曲记录',
          status: status,
          endText: '',
          onTap: () {
            Navigator.pushNamed(
              context,
              '/kojiMaking/steamLookRecordAdd',
              arguments: {
                'orderNo': widget.arguments['data']['orderNo'],
                'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
                'onType': 'record'
              },
            ).then((value) => value != null ? _initState() : _initState());
          },
        ),
      ),
    ];

    listData.asMap().keys.forEach((index) {
      widgetList.add(Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: SlideButton(
          index: index,
          child: ColumnItem(
            startText: '${listData[index]['guardDate']}',
            centerText: '${listData[index]['changer']}',
            status: '${listData[index]['status']}',
            endText: '${listData[index]['changed']}',
            onTap: () {
              Navigator.pushNamed(
                context,
                '/kojiMaking/steamLookRecordAdd',
                arguments: {'data': listData[index], 'onType': 'record'},
              ).then((value) => value != null ? _initState() : _initState());
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
                    shape: CircleBorder(side: BorderSide(color: Colors.red)),
                    child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'),
                        color: Colors.white, size: 16),
                    onPressed: () {
                      if (!(listData[index]['status'] == 'N' ||
                          listData[index]['status'] == 'R' ||
                          listData[index]['status'] == 'S' ||
                          listData[index]['status'] == 'T' ||
                          listData[index]['status'] == '')) {
                        return;
                      }
                      _del(index);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      type: '制曲',
      title: widget.arguments['title'],
      status: '$status',
      statusName: '$statusName',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle: '${widget.arguments['data']['materialName']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: pageData,
      addFlg: false,
      submitFn: () {
        _submit();
      },
      listWidget: _listWidget,
    );
  }
}

class ColumnItem extends StatefulWidget {
  final bool addFlag;
  final bool btnFlag;
  final String status;
  final String startText;
  final String centerText;
  final String endText;
  final Function onTap;
  ColumnItem(
      {Key key,
      this.addFlag = false,
      this.btnFlag = true,
      this.status = '',
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
        padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(children: <Widget>[
            Column(children: <Widget>[
              Text(
                widget.startText,
                style: TextStyle(color: Color(0xFF333333), fontSize: 16),
              ),
            ]),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      widget.centerText,
                      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                  ]),
                  Row(children: <Widget>[
                    Text(
                      widget.endText,
                      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                  ])
                ]),
              ),
            ),
            (widget.status == 'N' ||
                    widget.status == 'R' ||
                    widget.status == 'S' ||
                    widget.status == 'T' ||
                    widget.status == '')
                ? widget.btnFlag
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
                              size: 12,
                              color: Color(0xFF487BFF),
                            ),
                            onTap: widget.onTap,
                          )
                    : SizedBox()
                : SizedBox(),
          ]),
        )
//      child: Row(
//        children: <Widget>[
//          Text(
//            widget.startText,
//            style: TextStyle(color: Color(0xFF333333), fontSize: 14),
//          ),
//          SizedBox(width: 2),
//          Text(
//            widget.centerText,
//            style: TextStyle(color: Color(0xFF333333), fontSize: 12),
//          ),
//          Expanded(
//            flex: 1,
//            child: Text(
//              widget.endText,
//              textAlign: TextAlign.left,
//              style: TextStyle(color: Color(0xFF999999), fontSize: 14),
//            ),
//          ),
//          (widget.status == 'N' ||
//            widget.status == 'R' ||
//            widget.status == 'S' ||
//            widget.status == 'T' ||
//            widget.status == '')
//              ?
//              widget.btnFlag
//                ? widget.addFlag == true
//                ? InkWell(
//                  child: Icon(
//                    IconData(0xe69e, fontFamily: 'MdsIcon'),
//                    size: 20,
//                    color: Color(0xFF487BFF),
//                  ),
//                  onTap: widget.onTap,
//                )
//                  : InkWell(
//                      child: Icon(
//                        IconData(0xe62c, fontFamily: 'MdsIcon'),
//                        size: 12,
//                        color: Color(0xFF487BFF),
//                      ),
//                      onTap: widget.onTap,
//                    )
//                  : SizedBox()
//            : SizedBox(),
//        ],
//      ),
        );
  }
}
