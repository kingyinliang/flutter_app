import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          HomeHead(),
          HomeMenu(),
        ],
      ),
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
          menuIcon: Icons.pages,
        ),
        MenuItem(
          menuColor: 0xFFF6BD16,
          menuTitle: '半成品异常',
          menuSubTitle: 'Abnormal records',
          menuIcon: Icons.access_time,
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
          menuIcon: Icons.ac_unit,
        ),
        MenuItem(
          menuColor: 0xFF1677FF,
          menuTitle: '辅料添加',
          menuSubTitle: 'Accessories add',
          menuIcon: IconData(0xe61d, fontFamily: 'MdsIcon'),
        ),
        MenuItem(
          menuColor: 0xFF454955,
          menuTitle: '辅料异常',
          menuSubTitle: 'Abnormal records',
          menuIcon: Icons.account_box,
        ),
        MenuItem(
          menuColor: 0xFFE86452,
          menuTitle: '半成品领用',
          menuSubTitle: 'Semi-finished goods',
          menuIcon: Icons.opacity,
        ),
        MenuItem(
          menuColor: 0xFFE86452,
          menuTitle: '半成品领用',
          menuSubTitle: 'Semi-finished goods',
          menuIcon: Icons.edit_attributes,
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
  MenuItem(
      {Key key,
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
    return Container(
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
                    size: 55,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
