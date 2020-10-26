import 'package:dfmdsapp/utils/index.dart';

class SteamSidePage extends StatefulWidget {
  final arguments;
  SteamSidePage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamSidePageState createState() => _SteamSidePageState();
}

class _SteamSidePageState extends State<SteamSidePage> {
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
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'NO.${index + 1}',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '12',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Mpa',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconyali,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '气泡压力',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 35,
                color: Color(0xFFD8D8D8),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '12',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'L/H',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconguandaoyali_jingbao,
                          size: 20,
                          colors: ['#F6BD16'],
                        ),
                        SizedBox(width: 5),
                        Text(
                          '气泡压力',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 35,
                color: Color(0xFFD8D8D8),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '王晓蕾',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconFont(
                          IconNames.iconrenyuan,
                          size: 20,
                          colors: ['#E86452', '#E86452'],
                        ),
                        SizedBox(width: 5),
                        Text(
                          '气泡压力',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '张三  2020.05.21  19:28:25',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
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
        Navigator.pushNamed(context, '/kojiMaking/steamSideAdd', arguments: {});
      },
      submitFn: () {},
      listWidget: _listWidget,
    );
  }
}
