import 'package:dfmdsapp/utils/index.dart';

class SteamHybridControlPage extends StatefulWidget {
  final arguments;
  SteamHybridControlPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamHybridControlPageState createState() => _SteamHybridControlPageState();
}

class _SteamHybridControlPageState extends State<SteamHybridControlPage> {
  List listData = [];
  String status = '';
  String statusName = '';
  bool isSubmited = false;

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
        "dataType": "STEAM_CONTROL"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamHybridControlHome({
        "orderNo": widget.arguments['data']['orderNo'],
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo']
      });
      listData = res['data'];
      isSubmited = res['data'][0]['status'] == "D" ? true : false;
      listData = MapUtil.listNullToEmpty(listData);
      if (type) $successToast(context, msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      await KojiMaking.steamHybridControlSubmit({
        'id': listData[0]['id'],
        'orderNo': widget.arguments['data']['orderNo'],
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      await $successToast(context, msg: '操作成功');
      _initState(type: true);
    } catch (e) {}
  }

  Widget _listWidget(index) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: MdsCard(
        child: _listItemWidget(index),
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
                  'NO.1',
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
                          '/kojiMaking/steamHybridControlAdd',
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
                      '${listData[index]['mixtureStart']}',
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
                      '${listData[index]['mixtrueEnd']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '蒸面风冷温度',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '${listData[index]['flourWindTemp']}℃',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '混合料温度1',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '${listData[index]['mixtureTempOne']}℃',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '大豆风冷温度1',
                        style:
                            TextStyle(color: Color(0xFF999999), fontSize: 14),
                      ),
                      Text(
                        '${listData[index]['beanWindTempOne']}℃',
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '混合料温度2',
                        style:
                            TextStyle(color: Color(0xFF999999), fontSize: 14),
                      ),
                      Text(
                        '${listData[index]['mixtureTempTwo']}℃',
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '大豆风冷温度2',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '${listData[index]['beanWindTempTwo']}℃',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '大豆风冷变频',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '${listData[index]['beanWindFrequency']}Hz',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                ],
              ),
            ],
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
      headFourTitle: '生产日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      addFlg: listData.length > 0 ? false : true,
      submited: isSubmited,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamHybridControlAdd',
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
