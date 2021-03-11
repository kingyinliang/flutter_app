import 'package:dfmdsapp/utils/index.dart';

class SteamBeanHardnessPage extends StatefulWidget {
  final arguments;
  SteamBeanHardnessPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanHardnessPageState createState() => _SteamBeanHardnessPageState();
}

class _SteamBeanHardnessPageState extends State<SteamBeanHardnessPage> {
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
      var res = await KojiMaking.kojiSCOrderStatusQuery({
        "orderNo": widget.arguments['data']['orderNo'],
        "dataType": "STEAM_BEAN_HARDNESS"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamBeanHardnessHome({
        "orderNo": widget.arguments['data']['orderNo'],
      });
      listData = res['data'];
      listData = MapUtil.listNullToEmpty(listData);
      if (type) $successToast(context, msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      var ids = [];
      listData.forEach((element) {
        ids.add(element['id']);
      });
      await KojiMaking.steamBeanHardnessSubmit({
        'ids': ids,
        'orderNo': widget.arguments['data']['orderNo'],
      });
      $successToast(context, msg: '操作成功');
      _initState(type: true);
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.steamBeanHardnessDel({
        'id': listData[index]['id'],
        'orderNo': widget.arguments['data']['orderNo'],
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

  _listItemWidget(index) {
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
                          '/kojiMaking/steamBeanHardnessAdd',
                          arguments: {
                            'data': listData[index],
                            'orderNo': widget.arguments['data']['orderNo'],
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
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessOne']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度2',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessTwo']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度3',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessThree']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度4',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessFour']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度5',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessFive']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度6',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessSix']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度7',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessSeven']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度8',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessEight']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度9',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessNine']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度10',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '${listData[index]['hardnessTen']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Text('备注：${listData[index]['remark']}'),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
                '${listData[index]['changer']}  ${listData[index]['changed']}'),
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
        Navigator.pushNamed(context, '/kojiMaking/steamBeanHardnessAdd',
            arguments: {
              'orderNo': widget.arguments['data']['orderNo'],
            }).then((value) => value != null ? _initState() : null);
      },
      submitFn: () {
        _submit();
      },
      listWidget: _listWidget,
    );
  }
}
