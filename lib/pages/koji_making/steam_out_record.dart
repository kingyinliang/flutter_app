import 'package:dfmdsapp/utils/index.dart';

class SteamOutRecordPage extends StatefulWidget {
  final arguments;
  SteamOutRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamOutRecordPageState createState() => _SteamOutRecordPageState();
}

class _SteamOutRecordPageState extends State<SteamOutRecordPage> {
  List wrapList = [
    // {'label': '', 'value': 'addKojiInfo'},
    {'label': '出曲温度：', 'value': 'outKojiTemp', 'endlabel': '℃'},
    {'label': '出曲人：', 'value': 'outKojiMans'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
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
        "dataType": "DISC_OUT"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.steamDiscOutQuery(
          {"kojiOrderNo": widget.arguments['data']['kojiOrderNo']});
      if (res['data'] == null) {
        listData = [];
      } else {
        listData = [res['data']];
        isSubmited = res['data']['status'] == "D" ? true : false;
        listData = MapUtil.listNullToEmpty(listData);
        if (type) $successToast(context, msg: '操作成功');
      }
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      if (listData.length > 0) {
        await KojiMaking.steamDiscOutSubmit({
          'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
        });
        await $successToast(context, msg: '操作成功');
        _initState(type: true);
      } else {
        EasyLoading.showError('请先添加数据');
      }
    } catch (e) {}
  }

  _del(index) async {
    try {
      await KojiMaking.steamDiscOutDelete({'id': listData[index]['id']});
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
                          '/kojiMaking/steamOutRecordAdd',
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
                      '${listData[index]['outKojiStart']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${listData[index]['outKojiDuration']}H',
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
                      '${listData[index]['outKojiEnd']}',
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
      status: '$status',
      statusName: '$statusName',
      headTitle: '${widget.arguments['data']['kojiHouseName']}',
      headSubTitle:
          '${widget.arguments['data']['materialName']} ${widget.arguments['data']['materialCode']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      submited: isSubmited,
      addFlg: listData.length > 0 ? false : true,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamOutRecordAdd',
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
