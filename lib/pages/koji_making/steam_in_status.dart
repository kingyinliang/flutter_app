import 'package:dfmdsapp/utils/index.dart';

class SteamInStatusPage extends StatefulWidget {
  final arguments;
  SteamInStatusPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamInStatusPageState createState() => _SteamInStatusPageState();
}

class _SteamInStatusPageState extends State<SteamInStatusPage> {
  List wrapList = [
    {
      'label': '',
      'value': 'potNoName',
    }
  ];
  List listData = [
    {'potNoName': '111'}
  ];

  Widget _listWidget(index) {
    return SlideButton(
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
              InkWell(
                onTap: () {},
                child: Icon(
                  IconData(0xe62c, fontFamily: 'MdsIcon'),
                  size: 14,
                  color: Color(0xFF487BFF),
                ),
              ),
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
                      '2020.05.21 10:23',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '10min',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 12),
                  ),
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
                      '2020.05.21 10:23',
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
      title: widget.arguments['title'],
      headTitle: 'A-1  曲房',
      headSubTitle: '六月香生酱',
      headThreeTitle: '生产订单：83300023456',
      headFourTitle: '入曲日期：2020-07-20',
      listData: listData,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamInStatusAdd',
            arguments: {});
      },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}
