import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double _opacity = 0;
  List menuList = [];
  String factoryName = '';
  String workShopName = '';

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
    factoryName = await SharedUtil.instance.getStorage('factory');
    workShopName = await SharedUtil.instance.getStorage('workShop');
    try {
      var res = await Common.getMenuApi();
      menuList = res['data']['menuList'];
      setState(() {});
    } catch (e) {}
  }

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return Container(
      child: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification &&
                  notification.depth == 0) {
                _onScroll(notification.metrics.pixels);
              }
              return true;
            },
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  HomeHead(
                    factoryName: factoryName,
                    workShopName: workShopName,
                  ),
                  HomeMenu(
                    menu: menuList,
                  ),
                ],
              ),
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
                  "$factoryName-$workShopName",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 首页头部widget
class HomeHead extends StatefulWidget {
  final factoryName;
  final workShopName;
  HomeHead({Key key, this.factoryName, this.workShopName}) : super(key: key);

  @override
  _HomeHeadState createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                widget.factoryName ?? '',
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.workShopName ?? '',
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
          menuData: widget.menu[index]['remark'],
          menuTitle: widget.menu[index]['menuName'],
          menuSubTitle: widget.menu[index]['remark'],
          menuIcon: IconData(getColorFromHex(widget.menu[index]['menuIcon']),
              fontFamily: 'MdsIcon'),
        );
      },
    );
  }
}

// 首页单个菜单widget
class MenuItem extends StatefulWidget {
  final IconData menuIcon;
  final String menuTitle;
  final String menuSubTitle;
  final String url;
  final String menuData;
  MenuItem(
      {Key key,
      this.url,
      this.menuData,
      this.menuIcon,
      this.menuTitle,
      this.menuSubTitle})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  Map menu = {};

  _initState() {
    switch (widget.menuData) {
      case 'semi':
        menu = {
          'menuColor': 0xFFE86452,
          'workingType': 'semi',
          'menuSubTitle': 'Semi-finished goods',
        };
        break;
      case 'semiAbnormal':
        menu = {
          'menuColor': 0xFFF6BD16,
          'workingType': 'semiAbnormal',
          'menuSubTitle': 'Abnormal records',
          'blockType': 'exception',
          'typeParameters': 'semiReceive',
        };
        break;
      case 'material':
        menu = {
          'menuColor': 0xFF1677FF,
          'workingType': 'material',
          'menuSubTitle': 'Accessories add',
        };
        break;
      case 'materialAbnormal':
        menu = {
          'menuColor': 0xFF454955,
          'workingType': 'materialAbnormal',
          'menuSubTitle': 'Abnormal records',
          'blockType': 'exception',
          'typeParameters': 'acceadd',
        };
        break;
      case 'processor':
        menu = {
          'menuColor': 0xFF1E9493,
          'workingType': 'processor',
          'menuSubTitle': 'Process control',
        };
        break;
      case 'processorAbnormal':
        menu = {
          'menuColor': 0xFF5D7092,
          'workingType': 'processorAbnormal',
          'menuSubTitle': 'Abnormal records',
          'blockType': 'exception',
          'typeParameters': 'craft',
        };
        break;
      default:
        menu = {
          'menuColor': 0xFFE86452,
          'workingType': '',
          'menuSubTitle': '',
        };
    }
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 14, 12, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(menu['menuColor']),
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
              menu['menuSubTitle'],
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
        String urlString = '/sterilize/barcode';
        if (menu['workingType'] == 'processor') {
          urlString = widget.url;
        }
        Navigator.pushNamed(
          context,
          urlString,
          arguments: {
            'url': widget.url,
            'workingType': menu['workingType'],
            'title': widget.menuTitle,
            'blockType': menu['blockType'],
            'typeParameters': menu['typeParameters'],
          },
        );
      },
    );
  }
}
