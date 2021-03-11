import 'package:dfmdsapp/utils/index.dart';

class SteamTurnRecordPage extends StatefulWidget {
  final arguments;
  SteamTurnRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamTurnRecordPageState createState() => _SteamTurnRecordPageState();
}

class _SteamTurnRecordPageState extends State<SteamTurnRecordPage> {
  List wrapList = [
    {'label': '备注：', 'value': 'remark'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'}
  ];
  List listData = [];
  String status = '';
  String statusName = '';
  bool isSubmited = false; // form style if submitid ?

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

  _initState({type: false}) async {
    try {
      // 页签状态
      var res = await KojiMaking.kojiOrderStatusQuery({
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "dataType": "DISC_TURN"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamDiscTurnQuery({
        "orderNo": widget.arguments['data']['orderNo'],
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo']
      });

      if (res['data'] == null) {
        listData = [];
      } else {
        listData = res['data'];
        isSubmited =
            res['data'][0]["kojiDiscTurn1"]['status'] == "D" ? true : false;
        listData = MapUtil.listNullToEmpty(listData);
        if (type) $successToast(context, msg: '操作成功');
      }
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      await KojiMaking.steamDiscTurnSubmit({
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      await $successToast(context, msg: '操作成功');
      _initState(type: true);
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.steamDiscTurnDelet({
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      $successToast(context, msg: '操作成功');
      listData.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  Widget _listWidget(index) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: SlideButton(
        index: index,
        singleButtonWidth: 70,
        child: MdsCard(
          child: _listItemWidget(index),
        ),
        buttons: <Widget>[
          CardRemoveBtn(
            removeOnTab: () {
              if (!(listData[0]['kojiDiscTurn1']['status'] == 'N' ||
                  listData[0]['kojiDiscTurn1']['status'] == 'R' ||
                  listData[0]['kojiDiscTurn1']['status'] == 'S' ||
                  listData[0]['kojiDiscTurn1']['status'] == 'T' ||
                  listData[0]['kojiDiscTurn1']['status'] == '')) {
                return;
              }
              _del(index);
            },
          )
        ],
      ),
    );
  }

  Widget _listItemWidget(index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  '一翻',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                  ),
                ),
              ),
              (listData[0]['kojiDiscTurn1']['status'] == 'N' ||
                      listData[0]['kojiDiscTurn1']['status'] == 'R' ||
                      listData[0]['kojiDiscTurn1']['status'] == 'S' ||
                      listData[0]['kojiDiscTurn1']['status'] == 'T' ||
                      listData[0]['kojiDiscTurn1']['status'] == '')
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/kojiMaking/steamTurnRecordAdd',
                          arguments: {
                            'data': listData[index],
                            'orderNo': widget.arguments['data']['orderNo'],
                            'kojiOrderNo': widget.arguments['data']
                                ['kojiOrderNo'],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      },
                      child: Icon(
                        IconData(0xe62c, fontFamily: 'MdsIcon'),
                        size: 14,
                        color: Color(0xFF487BFF),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '开始时间',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['kojiDiscTurn1']['turnStart']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${listData[index]['kojiDiscTurn1']['turnDuration']}H',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset('lib/assets/images/arrows-to-right.png'),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '结束时间',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['kojiDiscTurn1']['turnEnd']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          WrapWidget(
            cardMap: listData[index]['kojiDiscTurn1'],
            wrapList: wrapList,
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  '二翻',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '开始时间',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['kojiDiscTurn2']['turnStart']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${listData[index]['kojiDiscTurn2']['turnDuration']}H',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset('lib/assets/images/arrows-to-right.png'),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '结束时间',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['kojiDiscTurn2']['turnEnd']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          WrapWidget(
            cardMap: listData[index]['kojiDiscTurn2'],
            wrapList: wrapList,
          ),
          SizedBox(height: 10),
          Text(
            '异常情况',
            style: TextStyle(fontSize: 15, color: Color(0xFF333333)),
          ),
          Text(
            '${listData[index]['exceptionInfo']}',
            style: TextStyle(fontSize: 15, color: Color(0xFF333333)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      type: '制曲',
      title: widget.arguments['title'],
      // status: listData.length > 0 ? '$status' : '',
      // statusName: listData.length > 0 ? '$statusName' : '未录入',
      status: '$status',
      statusName: '$statusName',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle: '${widget.arguments['data']['materialName']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      addFlg: listData.length > 0 ? false : true,
      submited: isSubmited,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamTurnRecordAdd',
            arguments: {
              'orderNo': widget.arguments['data']['orderNo'],
              'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
            }).then((value) => value != null ? _initState() : null);
      },
      submitFn: () {
        _submit();
      },
      listWidget: _listWidget,
    );
  }
}
