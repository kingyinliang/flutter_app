import 'package:dfmdsapp/utils/index.dart';

class SteamLookRecordPage extends StatefulWidget {
  final arguments;
  SteamLookRecordPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamLookRecordPageState createState() => _SteamLookRecordPageState();
}

class _SteamLookRecordPageState extends State<SteamLookRecordPage> {
  List pageData = [{}, {}];
  List listData = [{}, {}];

  Widget _listWidget(index) {
    if (index == 0) {
      return Column(
        children: _getList(),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '异常情况',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 17),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      IconData(0xe62c, fontFamily: 'MdsIcon'),
                      size: 15,
                      color: Color(0xFF487BFF),
                    ),
                    onTap: () {},
                  )
                ],
              ),
              SizedBox(height: 10),
              Text(
                '1、看曲过长出现异常2、曲房异常',
                style: TextStyle(color: Color(0xFF333333), fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<Widget> _getList() {
    List<Widget> widgetList = [
      Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: ColumnItem(
          addFlag: true,
          startText: '看曲记录',
          endText: '',
          onTap: () {},
        ),
      ),
    ];
    listData.asMap().keys.forEach((index) {
      widgetList.add(Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: SlideButton(
          index: index,
          child: ColumnItem(
            startText: '2020.08.01 08:00  张三  2020.08.01 08:00',
            endText: '',
            onTap: () {},
          ),
          singleButtonWidth: 60,
          buttons: <Widget>[
            Container(
              width: 60,
              color: Color(0xFFE8E8E8),
              child: Center(
                child: Container(
                  height: 24,
                  child: RaisedButton(
                    color: Colors.red,
                    shape: CircleBorder(side: BorderSide(color: Colors.red)),
                    child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'),
                        color: Colors.white, size: 16),
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      title: widget.arguments['title'],
      headTitle: 'A-1  曲房',
      headSubTitle: '六月香生酱',
      headThreeTitle: '生产订单：83300023456',
      headFourTitle: '入曲日期：2020-07-20',
      listData: pageData,
      addFlg: false,
      // addFn: () {
      //   Navigator.pushNamed(context, '/kojiMaking/steamLookRecordAdd',
      //       arguments: {});
      // },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}

class ColumnItem extends StatefulWidget {
  final bool addFlag;
  final bool btnFlag;
  final String startText;
  final String centerText;
  final String endText;
  final Function onTap;
  ColumnItem(
      {Key key,
      this.addFlag = false,
      this.btnFlag = true,
      this.startText = '',
      this.centerText = '',
      this.endText = '',
      this.onTap})
      : super(key: key);

  @override
  _ColumnItemState createState() => _ColumnItemState();
}

class _ColumnItemState extends State<ColumnItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.startText,
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
          SizedBox(width: 15),
          Text(
            widget.centerText,
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.endText,
              textAlign: TextAlign.right,
              style: TextStyle(color: Color(0xFF999999), fontSize: 17),
            ),
          ),
          SizedBox(width: 10),
          widget.btnFlag
              ? widget.addFlag == true
                  ? InkWell(
                      child: Icon(
                        IconData(0xe69e, fontFamily: 'MdsIcon'),
                        size: 20,
                        color: Color(0xFF487BFF),
                      ),
                      onTap: widget.onTap,
                    )
                  : InkWell(
                      child: Icon(
                        IconData(0xe62c, fontFamily: 'MdsIcon'),
                        size: 15,
                        color: Color(0xFF487BFF),
                      ),
                      onTap: widget.onTap,
                    )
              : SizedBox(),
        ],
      ),
    );
  }
}
