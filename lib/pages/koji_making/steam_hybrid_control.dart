import 'package:dfmdsapp/utils/index.dart';

class SteamHybridControlPage extends StatefulWidget {
  final arguments;
  SteamHybridControlPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamHybridControlPageState createState() => _SteamHybridControlPageState();
}

class _SteamHybridControlPageState extends State<SteamHybridControlPage> {
  List listData = [{}];

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
                    '45℃',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '混合料温度1',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '45℃',
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
                        '45℃',
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
                        '45℃',
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
                    '45℃',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '大豆风冷变频',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  ),
                  Text(
                    '45℃',
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
      title: widget.arguments['title'],
      headTitle: 'A-1  曲房',
      headSubTitle: '六月香生酱',
      headThreeTitle: '生产订单：83300023456',
      headFourTitle: '入曲日期：2020-07-20',
      listData: listData,
      addFn: () {
        Navigator.pushNamed(context, '/kojiMaking/steamHybridControlAdd',
            arguments: {});
      },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}
