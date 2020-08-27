import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacity = 0;
  _onScroll(offset) {
    double alpha = offset / 80;
    if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _opacity = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // NestedScrollView(
        //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //     return <Widget>[
        //       SliverOverlapAbsorber(
        //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        //         // ignore: deprecated_member_use
        //         child: SliverAppBar(
        //           backgroundColor: Color(0xFF5E8AFB),
        //           pinned: true,
        //           expandedHeight: 130.0,
        //           flexibleSpace: new FlexibleSpaceBar(
        //             title: Container(
        //                 padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
        //                 child: Row(
        //                   children: <Widget>[
        //                     Text(
        //                       "欣和企业-",
        //                       style: TextStyle(
        //                         fontSize: 20.0,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                     Text(
        //                       "杀菌一车间",
        //                       style: TextStyle(
        //                         height: 2.0,
        //                         fontSize: 12.0,
        //                         color: Colors.white,
        //                       ),
        //                     )
        //                   ],
        //                 )),
        //             background: Container(
        //               decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                   colors: [Color(0xFF5684FD), Color(0xFFB9CBFA)],
        //                   begin: Alignment.topCenter,
        //                   end: Alignment.bottomCenter,
        //                 ),
        //               ),
        //             ),
        //             centerTitle: true,
        //             collapseMode: CollapseMode.pin,
        //           ),
        //         ),
        //       )
        //     ];
        //   },
        //   body: Container(
        //     padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
        //     child: HomeMenu(),
        //   ),
        // );
        Stack(
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
              HomeMenu(),
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
          colors: [
            Color.fromRGBO(72, 123, 255, 1),
            Color.fromRGBO(245, 245, 245, 1)
          ],
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
  HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      crossAxisSpacing: 6,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      childAspectRatio: 1.06,
      children: <Widget>[
        MenuItem(
          menuColor: 0xFFE86452,
          menuTitle: '半成品领用',
          menuSubTitle: 'Semi-finished goods',
          menuIcon: IconData(0xe622, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          menuColor: 0xFFF6BD16,
          menuTitle: '半成品异常',
          menuSubTitle: 'Abnormal records',
          menuIcon: IconData(0xe625, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          menuColor: 0xFF1E9493,
          menuTitle: '工艺控制',
          menuSubTitle: 'Process control',
          menuIcon: IconData(0xe61e, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          menuColor: 0xFF5D7092,
          menuTitle: '工艺异常',
          menuSubTitle: 'Abnormal records',
          menuIcon: IconData(0xe623, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          url: '/sterilize/acceAddHome',
          menuColor: 0xFF1677FF,
          menuTitle: '辅料添加',
          menuSubTitle: 'Accessories add',
          menuIcon: IconData(0xe61d, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          menuColor: 0xFF454955,
          menuTitle: '辅料异常',
          menuSubTitle: 'Abnormal records',
          menuIcon: IconData(0xe625, fontFamily: 'MdsIcon'),
        ),
      ],
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
