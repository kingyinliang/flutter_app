import 'package:dfmdsapp/utils/index.dart';

class SteamBeanRecordPage extends StatefulWidget {
  final arguments;
  SteamBeanRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanRecordPageState createState() => _SteamBeanRecordPageState();
}

class _SteamBeanRecordPageState extends State<SteamBeanRecordPage> {
  List wrapList = [
    {'label': '汽包压力：', 'value': 'steamPocketPressure', 'endlabel': 'Mpa'},
    {'label': '蒸煮', 'value': 'cookingDuration', 'endlabel': 'min'},
    {'label': '圈数', 'value': 'turnCount'},
    {'label': '保压', 'value': 'pressureDuration', 'endlabel': 'min'},
    {'label': '熟豆放豆时间', 'value': 'addBeanDate'},
    {'label': '备注：', 'value': 'remark'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
  ];
  List listData = [];
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

  _initState({type: false}) async {
    try {
      // 判断来自蒸豆还是蒸面
      if (widget.arguments['data']['kojiOrderNo'] == '') {
        var res = await KojiMaking.kojiSCOrderStatusQuery({
          "orderNo": widget.arguments['data']['orderNo'],
          "dataType": "STEAM_BEAN"
        });
        status = res['data']['status'];
        statusName = res['data']['statusName'];
      } else {
        var res = await KojiMaking.kojiOrderStatusQuery({
          "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
          "dataType": "STEAM_BEAN"
        });
        status = res['data']['status'];
        statusName = res['data']['statusName'];
      }

      setState(() {});
    } catch (e) {}

    try {
      if (widget.arguments['data']['kojiOrderNo'] == '') {
        var res = await KojiMaking.steamBeanRecordHome(
            {"orderNo": widget.arguments['data']['orderNo']});
        listData = res['data'];
        listData = MapUtil.listNullToEmpty(listData);
      } else {
        var res = await KojiMaking.steamBeanRecordHome({
          "orderNo": widget.arguments['data']['orderNo'],
          "kojiOrderNo": widget.arguments['data']['kojiOrderNo']
        });
        listData = res['data'];
        listData = MapUtil.listNullToEmpty(listData);
      }

      if (type) successToast(msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      var ids = [];
      listData.forEach((element) {
        if (element['status'] == 'S') {
          ids.add(element['id']);
        }
      });
      if (ids.length != 0) {
        await KojiMaking.steamBeanRecordSubmit({
          'ids': ids,
          'orderNo': widget.arguments['data']['orderNo'],
          'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
        });
        successToast(msg: '操作成功');
        _initState(type: true);
      } else {
        infoToast(msg: "无数据可提交");
      }
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.steamBeanRecordDel({
        'id': listData[index]['id'],
        'orderNo': widget.arguments['data']['orderNo'],
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      successToast(msg: '操作成功');
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
              if (!(listData[index]['status'] == 'N' ||
                  listData[index]['status'] == 'R' ||
                  listData[index]['status'] == 'S' ||
                  listData[index]['status'] == 'T' ||
                  listData[index]['status'] == '')) {
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
                  '${listData[index]['steamBallName']}',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                  ),
                ),
              ),
              (listData[index]['status'] == 'N' ||
                      listData[index]['status'] == 'R' ||
                      listData[index]['status'] == 'S' ||
                      listData[index]['status'] == 'T' ||
                      listData[index]['status'] == '')
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/kojiMaking/steamBeanRecordAdd',
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
                      '${listData[index]['addSteamStart']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '',
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
                      '${listData[index]['addSteamEnd']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          WrapWidget(
            cardMap: listData[index],
            wrapList: wrapList,
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
      // status: '$status',
      // statusName: '$statusName',
      status: '$status',
      statusName: '$statusName',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle: '${widget.arguments['data']['materialName']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamBeanRecordAdd',
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
