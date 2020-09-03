import 'package:flutter/material.dart';
import '../../../api/api/index.dart';
import '../../../utils/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacity = 0;
  List menuList = [];
  _onScroll(offset) {
    double alpha = offset / 80;
    if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _opacity = alpha;
    });
  }

  _initState() async {
    var a = 0xe622;
    print(a.runtimeType.toString());
    try {
      var res = await Common.getMenuApi();
      menuList = res['data']['menuList'];
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _initState();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification &&
                notification.depth == 0) {
              _onScroll(notification.metrics.pixels);
            }
            return true;
          },
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              HomeHead(),
              HomeMenu(
                menu: menuList,
              ),
            ],
          ),
        ),
        Opacity(
          opacity: _opacity,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(72, 123, 255, 1),
                  Color.fromRGBO(156, 183, 253, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                "欣和企业-杀菌一车间",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 首页头部widget
class HomeHead extends StatefulWidget {
  HomeHead({Key key}) : super(key: key);

  @override
  _HomeHeadState createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4E7FFE), Color(0xFF83A5FC), Color(0xFF9CB7FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(15, 22, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "欣和企业",
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "杀菌一车间",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}

// 首页菜单widget
class HomeMenu extends StatefulWidget {
  final List menu;
  HomeMenu({Key key, this.menu}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 6,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 1.06,
      ),
      itemCount: widget.menu.length,
      itemBuilder: (context, index) {
        return MenuItem(
          url: widget.menu[index]['menuUrl'],
          menuColor: getColorFromHex(widget.menu[index]['permission']),
          menuTitle: widget.menu[index]['menuName'],
          menuSubTitle: widget.menu[index]['remark'],
          menuIcon: IconData(getColorFromHex(widget.menu[index]['menuIcon']),
              fontFamily: 'MdsIcon'),
        );
      },
      // children: <Widget>[
      //   MenuItem(
      //     url: '/sterilize/semiReceive/home',
      //     menuColor: 0xFFE86452,
      //     menuTitle: '半成品领用',
      //     menuSubTitle: 'Semi-finished goods',
      //     menuIcon: IconData(0xe622, fontFamily: 'MdsIcon'),
      //   ),
      //   MenuItem(
      //     menuColor: 0xFFF6BD16,
      //     menuTitle: '半成品异常',
      //     menuSubTitle: 'Abnormal records',
      //     menuIcon: IconData(0xe625, fontFamily: 'MdsIcon'),
      //   ),
      //   MenuItem(
      //     menuColor: 0xFF1E9493,
      //     menuTitle: '工艺控制',
      //     menuSubTitle: 'Process control',
      //     menuIcon: IconData(0xe61e, fontFamily: 'MdsIcon'),
      //   ),
      //   MenuItem(
      //     menuColor: 0xFF5D7092,
      //     menuTitle: '工艺异常',
      //     menuSubTitle: 'Abnormal records',
      //     menuIcon: IconData(0xe623, fontFamily: 'MdsIcon'),
      //   ),
      //   MenuItem(
      //     url: '/sterilize/acceAdd/home',
      //     menuColor: 0xFF1677FF,
      //     menuTitle: '辅料添加',
      //     menuSubTitle: 'Accessories add',
      //     menuIcon: IconData(0xe61d, fontFamily: 'MdsIcon'),
      //   ),
      //   MenuItem(
      //     menuColor: 0xFF454955,
      //     menuTitle: '辅料异常',
      //     menuSubTitle: 'Abnormal records',
      //     menuIcon: IconData(0xe625, fontFamily: 'MdsIcon'),
      //   ),
      // ],
    );
  }
}

// 首页单个菜单widget
class MenuItem extends StatefulWidget {
  final menuColor;
  final IconData menuIcon;
  final String menuTitle;
  final String menuSubTitle;
  final String url;
  MenuItem(
      {Key key,
      this.url,
      this.menuColor,
      this.menuIcon,
      this.menuTitle,
      this.menuSubTitle})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 14, 12, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(widget.menuColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.menuTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              widget.menuSubTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      widget.menuIcon,
                      size: 62,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print('object');
        Navigator.pushNamed(context, widget.url);
      },
    );
  }
}
