import 'package:dfmdsapp/utils/index.dart';

class SteamGrowEvaluatePage extends StatefulWidget {
  final arguments;
  SteamGrowEvaluatePage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamGrowEvaluatePageState createState() => _SteamGrowEvaluatePageState();
}

class _SteamGrowEvaluatePageState extends State<SteamGrowEvaluatePage> {
  // tag
  List wrapList = [
    {'label': '异常描述：', 'value': 'exceptionInfo'},
    {'label': '生长情况：', 'value': 'growInfoName'},
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
      // 页签状态
      var res = await KojiMaking.kojiOrderStatusQuery({
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "dataType": "DISC_EVALUATE"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamDiscEvaluateQuery(
          {"kojiOrderNo": widget.arguments['data']['kojiOrderNo']});
      listData = res['data'];
      listData = MapUtil.listNullToEmpty(listData);
      if (type) $successToast(context, msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      await KojiMaking.steamDiscEvaluateSubmit({
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      await $successToast(context, msg: '操作成功');
      _initState(type: true);
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.steamDiscEvaluateDelete({
        'id': listData[index]['id'],
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
                  'No.${index + 1}',
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
                          '/kojiMaking/steamGrowEvaluateAdd',
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
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '评估阶段',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['kojiStageName']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '记录时间',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['recordDate']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '记录人',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                    ),
                    Text(
                      '${listData[index]['recordMans'].split(",")[0]}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 14),
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
      status: '$status',
      statusName: '$statusName',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle: '${widget.arguments['data']['materialName']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamGrowEvaluateAdd',
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
