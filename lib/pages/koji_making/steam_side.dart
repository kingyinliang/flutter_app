import 'package:dfmdsapp/utils/index.dart';

class SteamSidePage extends StatefulWidget {
  final arguments;
  SteamSidePage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamSidePageState createState() => _SteamSidePageState();
}

class _SteamSidePageState extends State<SteamSidePage> {
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
        "dataType": "STEAM_FLOUR"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamSideHome({
        "orderNo": widget.arguments['data']['orderNo'],
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo']
      });
      listData = res['data'];
      isSubmited = res['data'][0]['status'] == "D" ? true : false;
      listData = MapUtil.listNullToEmpty(listData);
      if (type) successToast(msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      await KojiMaking.steamSideSubmit({
        'id': listData[0]['id'],
        'orderNo': widget.arguments['data']['orderNo'],
        'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
      });
      successToast(msg: '操作成功');
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
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'NO.${index + 1}',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12,
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
                          '/kojiMaking/steamSideAdd',
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
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${listData[index]['steamPacketPressure']}',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Mpa',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconyali,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '汽包压力',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 35,
                color: Color(0xFFD8D8D8),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${listData[index]['steamFlourSpeed']}',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'L/H',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconguandaoyali_jingbao,
                          size: 20,
                          colors: ['#F6BD16'],
                        ),
                        SizedBox(width: 5),
                        Text(
                          '蒸面加水加压',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 35,
                color: Color(0xFFD8D8D8),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Center(
                        child: Text(
                          '${listData[index]['steamFlourMans']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconrenyuan,
                          size: 20,
                          colors: ['#E86452', '#E86452'],
                        ),
                        SizedBox(width: 5),
                        Text(
                          '蒸面操作人',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${listData[index]['changer']}  ${listData[index]['changed']}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
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
        Navigator.pushNamed(context, '/kojiMaking/steamSideAdd', arguments: {
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
