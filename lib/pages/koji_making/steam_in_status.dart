import 'package:dfmdsapp/utils/index.dart';

class SteamInStatusPage extends StatefulWidget {
  final arguments;
  SteamInStatusPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamInStatusPageState createState() => _SteamInStatusPageState();
}

class _SteamInStatusPageState extends State<SteamInStatusPage> {
  List wrapList = [
    {'label': '', 'value': 'addKojiInfo'},
    {'label': '入曲温度：', 'value': 'addKojiTemp', 'endlabel': '℃'},
    {'label': '入曲人：', 'value': 'addKojiMans'},
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

  _initState() async {
    try {
      // 页签状态
      var res = await KojiMaking.kojiMakingOrder({
        "kojiOrderNo": widget.arguments['data']['kojiOrderNo'],
        "dataType": "DISC_IN"
      });
      status = res['data']['status'];
      statusName = res['data']['statusName'];
      setState(() {});
    } catch (e) {}

    try {
      var res = await KojiMaking.discInQuery(
          {"kojiOrderNo": widget.arguments['data']['kojiOrderNo']});
      if (res['data'] == null) {
        listData = [];
      } else {
        // 因为入库会自动带数据，加入判断滤掉
        if (res['data']['id'] != '') {
          listData = [res['data']];
        }
        isSubmited = res['data']['status'] == "D" ? true : false;
        listData = MapUtil.listNullToEmpty(listData);
      }
      setState(() {});
    } catch (e) {}
  }

  _submit() async {
    try {
      if (listData.length > 0) {
        for (Map planet in listData) {
          if (planet['addKojiInfo'] == null || planet['addKojiInfo'] == '') {
            EasyLoading.showError('请填写入曲情况');
            return;
          }
          if (planet['addKojiMans'] == null || planet['addKojiMans'] == '') {
            EasyLoading.showError('请填写入曲人');
            return;
          }
          if (planet['addKojiTemp'] == null || planet['addKojiTemp'] == '') {
            EasyLoading.showError('请填写入曲温度');
            return;
          }
          if (planet['addKojiStart'] == null || planet['addKojiStart'] == '') {
            EasyLoading.showError('请选择入曲开始时间');
            return;
          }
          if (planet['addKojiEnd'] == null || planet['addKojiEnd'] == '') {
            EasyLoading.showError('请选择入曲结束时间');
            return;
          }
        }
        await KojiMaking.discInSubmitQuery({
          'kojiOrderNo': widget.arguments['data']['kojiOrderNo'],
        });
        await $successToast(context, msg: '操作成功');
        _initState();
      } else {
        EasyLoading.showError('请先添加数据');
      }
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
            removeOnTab: () {},
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
                          '/kojiMaking/steamInStatusAdd',
                          arguments: {
                            'data': listData[index],
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
                      (listData[index]['addKojiStart'] == null ||
                              listData[index]['addKojiStart'] == '')
                          ? ''
                          : listData[index]['addKojiStart'],
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${listData[index]['addKojiDuration']}H',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
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
                      (listData[index]['addKojiEnd'] == null ||
                              listData[index]['addKojiEnd'] == '')
                          ? ''
                          : listData[index]['addKojiEnd'],
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
      headTitle: widget.arguments['data']['kojiHouseName'],
      headSubTitle:
          '${widget.arguments['data']['materialName']} ${widget.arguments['data']['materialCode']}',
      headThreeTitle: '生产订单：${widget.arguments['data']['orderNo']}',
      headFourTitle: '入曲日期：${widget.arguments['data']['productDate']}',
      listData: listData,
      addFlg: listData.length > 0 ? false : true,
      submited: isSubmited,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamInStatusAdd',
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
