import 'package:dfmdsapp/utils/index.dart';

class ExeptionWidget extends StatefulWidget {
  final String title;
  final String textField;
  final List exceptionList;
  final List textList;
  final Function addOnFn;
  final Function textOnFn;
  final Function exeOnFn;
  final Function delFn;
  final String status;
  final String statusName;
  final String headTitle;
  final String headSubTitle;
  final String headThreeTitle;
  final String headFourTitle;

  ExeptionWidget({
    Key key,
    this.title,
    this.textField,
    this.exceptionList,
    this.textList,
    this.addOnFn,
    this.textOnFn,
    this.exeOnFn,
    this.delFn,
    this.status,
    this.statusName,
    this.headTitle,
    this.headSubTitle,
    this.headThreeTitle,
    this.headFourTitle,
  }) : super(key: key);

  @override
  _ExeptionWidgetState createState() => _ExeptionWidgetState();
}

class _ExeptionWidgetState extends State<ExeptionWidget> {
  int _tabIndex = 0;
  List wrapList = [
    {'label': '班次：', 'value': 'classesName'},
    {'label': '异常情况：', 'value': 'exceptionSituationName'},
    {'label': '异常原因：', 'value': 'exceptionReasonName'},
    {'label': '异常描述：', 'value': 'exceptionInfo'},
    {'label': '备注：', 'value': 'remark'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
  ];

  // 获取tab切换index
  void setFloatingActionButtonFlag(int index) {
    _tabIndex = index;
    setState(() {});
  }

  // 是否显示加号
  bool _isButtonFlag(int tabIndex) {
    bool buttonFlag = true;
    if (tabIndex == 1) {
      buttonFlag = widget.textList.length == 1 ? false : true;
    } else {
      buttonFlag = true;
    }
    return buttonFlag;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: widget.title),
        backgroundColor: Color(0xFFF5F5F5),
        body: SliverTabBarWidget(
          tabChange: setFloatingActionButtonFlag,
          children: <Widget>[
            SizedBox(height: 5),
            PageHead(
              title: '${widget.headTitle}',
              subTitle: '${widget.headSubTitle}',
              threeTitle: '${widget.headThreeTitle}',
              fourTitle: '${widget.headFourTitle}',
              status: '${widget.status}',
              statusName: '${widget.statusName}',
            ),
            SizedBox(height: 5),
          ],
          tabBarChildren: <Widget>[
            Tab(text: '异常记录'),
            Tab(text: '其他记录'),
          ],
          tabBarViewChildren: <Widget>[
            ListView.builder(
              padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
              itemCount: widget.exceptionList.length,
              itemBuilder: (context, index) {
                return SlideButton(
                  index: index,
                  singleButtonWidth: 70,
                  child: ExceptionItemCard(
                    idx: index,
                    startTime: 'startDate',
                    endTime: 'endDate',
                    cardMap: widget.exceptionList[index],
                    wrapList: wrapList,
                    onTap: () {
                      widget.exeOnFn(index);
                    },
                  ),
                  buttons: <Widget>[
                    CardRemoveBtn(
                      removeOnTab: () => widget.delFn(index),
                    ),
                  ],
                );
              },
            ),
            ListView.builder(
              padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
              itemCount: widget.textList.length,
              itemBuilder: (context, index) {
                return MdsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            widget.textOnFn(index);
                          },
                          child: Icon(
                            IconData(0xe62c, fontFamily: 'MdsIcon'),
                            size: 16,
                            color: Color(0xFF487BFF),
                          ),
                        ),
                      ),
                      Text('${widget.textList[index][widget.textField]}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
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
                child: _isButtonFlag(_tabIndex)
                    ? FloatingActionButton(
                        onPressed: () {
                          widget.addOnFn(_tabIndex);
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
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset('lib/assets/images/arrows-to-right.png'),
                  ),
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
