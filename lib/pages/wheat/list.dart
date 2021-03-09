import 'package:dfmdsapp/utils/index.dart';

class WheatListPage extends StatefulWidget {
  final arguments;

  WheatListPage({Key key, this.arguments}) : super(key: key);

  @override
  _WheatListPageState createState() => _WheatListPageState();
}

class _WheatListPageState extends State<WheatListPage> {
  bool checkboxStatus = false;
  List dataList = [];

  // 同步
  _getOrderList() async {
    try {
      String productLineCode =
          await SharedUtil.instance.getStorage('productLineCode');
      String workShopCode =
          await SharedUtil.instance.getStorage('workShopCode');
      var res = await Wheat.wheatOrderListApi({
        'workShopCode': workShopCode,
        'productLineCode': productLineCode,
        'orderList': []
      });
      await SharedUtil.instance.saveMapStorage('orderList', res['list']);
      await SharedUtil.instance
          .saveMapStorage('wheatDeviceList', res['wheatDeviceList']);
      await SharedUtil.instance
          .saveMapStorage('flourDeviceList', res['flourDeviceList']);
    } catch (e) {}
  }

  // 上传
  _upLoadOrder() {
    setState(() {
      if (checkboxStatus == false) {
        checkboxStatus = true;
      }
    });
  }

  // 入库表格表头
  Widget _listTitle(item, orderIndex) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/qufang.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: Color(0xF2F2F2FF),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                item['kojiHouseName'] == ''
                    ? SizedBox()
                    : Text(
                        '${item['kojiHouseName']}',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF333333)),
                      ),
                Text(
                  '${item['materialCode']} ${item['materialName']}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                ),
                Text(
                  '${item['orderNo']}',
                  style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                '${item['statusName']}',
                style: TextStyle(fontSize: 13, color: Color(0xFF333333)),
              ),
              Text(
                '${item['productDate']}',
                style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 入库表格表体
  Widget _listBody(item, orderIndex) {
    List<Widget> widgetArr = [];
    widgetArr.add(Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '小麦粉入库',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        InkWell(
          child: Icon(
            Icons.add,
            color: Color(0xFF999999),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/wheat/add',
              arguments: {
                'orderIndex': orderIndex,
              },
            ).then((value) => value != null ? _init() : null);
          },
        )
      ],
    ));
    widgetArr.add(Container(
      height: 30,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '麦粉计量仓',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '起始',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '结束',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '数量(KG)',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ),
          Container(
            width: 16,
          ),
        ],
      ),
    ));
    widgetArr.add(
      Container(
        height: 1,
        color: Color(0xFFD8D8D8),
      ),
    );
    for (var index = 0; index < item['table'].length; index++) {
      widgetArr.add(InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/wheat/add',
            arguments: {
              'orderIndex': orderIndex,
              'tableIndex': index,
            },
          ).then((value) => value != null ? _init() : null);
        },
        child: Container(
          height: 30,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  '麦粉计量仓',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '起始',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '结束',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '数量(KG)',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 16,
                color: Color(0xFF333333),
              ),
            ],
          ),
        ),
      ));
      widgetArr.add(
        Container(
          height: 1,
          color: Color(0xFFD8D8D8),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
      child: Column(
        children: widgetArr,
      ),
    );
  }

  // 折叠面板结构
  Widget _getExpansionPanelList(item, orderIndex) {
    ExpansionPanel expansionPanel = ExpansionPanel(
      isExpanded: item['isExpanded'],
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        return _listTitle(item, orderIndex);
      },
      body: _listBody(item, orderIndex),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            item['isExpanded'] = !isExpanded;
          });
        },
        children: <ExpansionPanel>[expansionPanel],
      ),
    );
  }

  // 滑动结构
  Widget _getSlide(item, orderIndex) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          left: 0,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value:
                            item['checkbox'] != null ? item['checkbox'] : false,
                        onChanged: (value) {
                          setState(() {
                            item['checkbox'] = value;
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ),
        RawGestureDetector(
          child: Transform.translate(
            offset: Offset(checkboxStatus == false ? 0 : 50, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _getExpansionPanelList(item, orderIndex),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  // 列表结构
  Widget _getListPage() {
    List<Widget> widgetArr = dataList.asMap().keys.map((index) {
      return _getSlide(dataList[index], index);
    }).toList();
    return ListView(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 60), children: widgetArr);
  }

  // 底部按钮
  Widget _getButton() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: pxUnit(375),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          children: <Widget>[
            checkboxStatus == false
                ? Expanded(
                    flex: 1,
                    child: Container(
                      height: 49,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        child: Container(
                          child: Text(
                            '同步',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        onPressed: _getOrderList,
                      ),
                    ),
                  )
                : SizedBox(),
            checkboxStatus == true
                ? Expanded(
                    flex: 1,
                    child: Container(
                      height: 49,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Colors.black,
                        child: Container(
                          child: Text(
                            '取消',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            checkboxStatus = false;
                          });
                        },
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 49,
                child: RaisedButton(
                  color: Color.fromRGBO(72, 123, 255, 1),
                  textColor: Colors.white,
                  child: Container(
                    child: Text(
                      '上传',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onPressed: _upLoadOrder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _init() async {
    dataList = await SharedUtil.instance.getMapStorage('orderList');
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _init();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: widget.arguments['title']),
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: <Widget>[_getListPage(), _getButton()],
      ),
    );
  }
}
