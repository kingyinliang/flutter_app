import 'package:dfmdsapp/utils/index.dart';

class ExeptionPage extends StatefulWidget {
  final arguments;
  ExeptionPage({Key key, this.arguments}) : super(key: key);

  @override
  _ExeptionPageState createState() => _ExeptionPageState();
}

class _ExeptionPageState extends State<ExeptionPage> {
  bool _floatingActionButtonFlag = true;
  int _tabIndex = 0;
  List exceptionList = []; // 异常列表
  List textList = []; // 文本列表

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  _initState() async {
    _floatingActionButtonFlag = this._isButtonFlag(_tabIndex);
    setState(() {});
  }

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    _floatingActionButtonFlag = this._isButtonFlag(index);
    _tabIndex = index;
    setState(() {});
  }

  // 是否显示加号
  _isButtonFlag(int tabIndex) {
    bool buttonFlag = true;
    if (tabIndex == 1) {
      buttonFlag = this.textList.length == 1 ? false : true;
    } else {
      buttonFlag = true;
    }
    return buttonFlag;
  }

  // 异常删除
  _delPot(index) async {
    try {
      await Sterilize.sterilizeExceptionDetailDeleteApi(
          [this.exceptionList[index]['id']]);
      successToast(msg: '操作成功');
      this.exceptionList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: widget.arguments['title']),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
            tabChange: setFloatingActionButtonFlag,
            children: <Widget>[
              SizedBox(height: 5),
              PageHead(
                title: 'A-1  曲房',
                subTitle: '六月香生酱',
                threeTitle: '生产订单：83300023456',
                fourTitle: '入曲日期：2020-07-20',
              ),
              SizedBox(height: 5),
            ],
            tabBarChildren: <Widget>[
              Tab(text: '异常记录'),
              Tab(text: '其他记录'),
            ],
            tabBarViewChildren: <Widget>[
              DateListWidget(
                data: this.exceptionList,
                updataFn: _initState,
                arguments: {
                  'typeCode': widget.arguments['typeCode'],
                  'potDetail': widget.arguments['potDetail'],
                },
                delFn: _delPot,
              ),
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
                  itemCount: this.textList.length,
                  itemBuilder: (context, index) {
                    return TextCard(
                      dataList: this.textList,
                      text: 'text',
                      idx: index,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/sterilize/exception/textAdd',
                          arguments: {
                            'typeCode': widget.arguments['typeCode'],
                            'potDetail': widget.arguments['potDetail'],
                            'data': this.textList[index],
                          },
                        ).then((value) => value != null ? _initState() : null);
                      },
                    );
                  })
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
                child: _floatingActionButtonFlag
                    ? FloatingActionButton(
                        onPressed: () {
                          if (_tabIndex == 0) {
                            Navigator.pushNamed(
                              context,
                              '/sterilize/exception/add',
                              arguments: {
                                'typeCode': widget.arguments['typeCode'],
                                'potDetail': widget.arguments['potDetail'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          } else {
                            Navigator.pushNamed(
                              context,
                              '/sterilize/exception/textAdd',
                              arguments: {
                                'typeCode': widget.arguments['typeCode'],
                                'potDetail': widget.arguments['potDetail'],
                              },
                            ).then(
                                (value) => value != null ? _initState() : null);
                          }
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 异常list
class DateListWidget extends StatefulWidget {
  final Map arguments;
  final List data;
  final Function updataFn;
  final Function delFn;
  DateListWidget(
      {Key key, this.arguments, this.data, this.updataFn, this.delFn})
      : super(key: key);

  @override
  _DateListWidgetState createState() => _DateListWidgetState();
}

class _DateListWidgetState extends State<DateListWidget>
    with AutomaticKeepAliveClientMixin {
  List wrapList = [
    {'label': '班次：', 'value': 'classesName'},
    {'label': '异常情况：', 'value': 'exceptionSituationName'},
    {'label': '异常原因：', 'value': 'exceptionReasonName'},
    {'label': '异常描述：', 'value': 'exceptionInfo'},
    {'label': '备注：', 'value': 'remark'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return SlideButton(
          index: index,
          singleButtonWidth: 70,
          child: ExceptionItemCard(
            idx: index,
            startTime: 'startDate',
            endTime: 'endDate',
            cardMap: widget.data[index],
            wrapList: wrapList,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/sterilize/exception/add',
                arguments: {
                  'typeCode': widget.arguments['typeCode'],
                  'potDetail': widget.arguments['potDetail'],
                  'data': widget.data[index],
                },
              ).then((value) => value != null ? widget.updataFn() : null);
            },
          ),
          buttons: <Widget>[
            CardRemoveBtn(
              removeOnTab: () => widget.delFn(index),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// 单个文本
class TextCard extends StatefulWidget {
  final Function onTap;
  final List dataList; // 数据列表
  final String text;
  final int idx;
  final bool isEdit; // 是否显示修改按钮
  TextCard(
      {Key key,
      this.dataList,
      this.text,
      this.onTap,
      this.idx,
      this.isEdit = true})
      : super(key: key);
  @override
  _TextCardState createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    return MdsCard(
        child: Stack(children: <Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            Container(
              child: widget.isEdit
                  ? InkWell(
                      onTap: widget.onTap,
                      child: Icon(
                        IconData(0xe62c, fontFamily: 'MdsIcon'),
                        size: 16,
                        color: Color(0xFF487BFF),
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ),
        SizedBox(height: 10),
        Text('${widget.dataList[widget.idx][widget.text]}'),
        SizedBox(height: 10),
      ])
    ]));
  }
}

// 单个异常
class ExceptionItemCard extends StatefulWidget {
  final int idx;
  final Function onTap;
  final String startTime;
  final String endTime;
  final Map cardMap;
  final List wrapList;
  final bool isEdit; // 是否显示修改按钮
  ExceptionItemCard(
      {Key key,
      this.idx,
      this.onTap,
      this.startTime,
      this.endTime,
      this.cardMap,
      this.wrapList,
      this.isEdit = true})
      : super(key: key);
  @override
  _ExceptionItemCardState createState() => _ExceptionItemCardState();
}

class _ExceptionItemCardState extends State<ExceptionItemCard> {
  List colorList = [0xFFCDDDFD, 0xFFD3EEF9, 0xFFF8D0CB, 0xFFCDF3E4, 0xFFFCEBB9];
  int index = -1;

  List<Widget> _wrapList() {
    List<Widget> wrapList = [];
    widget.wrapList.asMap().keys.forEach((i) {
      if (widget.cardMap[widget.wrapList[i]['value']] == null ||
          widget.cardMap[widget.wrapList[i]['value']] == '') {
      } else {
        if (index > 3) {
          index = -1;
        }
        index++;
        wrapList.add(Container(
          padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
          decoration: BoxDecoration(
            color: Color(colorList[index]),
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Text(
            widget.wrapList[i]['label'] +
                (widget.cardMap[widget.wrapList[i]['value']] == null
                    ? ''
                    : widget.cardMap[widget.wrapList[i]['value']].toString()),
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ));
      }
    });
    index = -1;
    return wrapList;
  }

  @override
  Widget build(BuildContext context) {
    return MdsCard(
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'NO.${widget.idx + 1}',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 14.0,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    child: widget.isEdit
                        ? InkWell(
                            onTap: widget.onTap,
                            child: Icon(
                              IconData(0xe62c, fontFamily: 'MdsIcon'),
                              size: 16,
                              color: Color(0xFF487BFF),
                            ),
                          )
                        : SizedBox(),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text('开始时间'),
                  Expanded(
                    child: Text('${widget.cardMap['duration']}分钟',
                        textAlign: TextAlign.center),
                  ),
                  Text('结束时间')
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(''),
                  ),
                  Text('------------->'),
                  Expanded(
                    child: Text(''),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                      widget.cardMap[widget.startTime] == null
                          ? ''
                          : widget.cardMap[widget.startTime],
                      style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Text(''),
                  ),
                  Text(
                      widget.cardMap[widget.endTime] == null
                          ? ''
                          : widget.cardMap[widget.endTime],
                      style: TextStyle(fontSize: 18))
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: _wrapList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
