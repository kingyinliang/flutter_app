import 'package:dfmdsapp/utils/index.dart';

class SteamBeanHardnessPage extends StatefulWidget {
  final arguments;
  SteamBeanHardnessPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanHardnessPageState createState() => _SteamBeanHardnessPageState();
}

class _SteamBeanHardnessPageState extends State<SteamBeanHardnessPage> {
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
                  '001#蒸球',
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
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '1223.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
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
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '硬度1',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    Text(
                      '42.5',
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
            child: Text('备注：我'),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text('张三  2020.05.21  19:28:25'),
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
        Navigator.pushNamed(context, '/kojiMaking/steamBeanHardnessAdd',
            arguments: {});
      },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}
