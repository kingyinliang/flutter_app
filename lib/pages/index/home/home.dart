import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/pxunit.dart';
import 'package:dfmdsapp/assets/iconfont/IconFont.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List menuList = [];
  String factoryName = '';
  String workShopName = '';

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
          ListView(
            padding: EdgeInsets.fromLTRB(0, pxUnit(50), 0, 0),
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
          Positioned(
            top: 0,
            child: Container(
              width: pxUnit(375),
              height: pxUnit(50),
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
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 160.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.blue,
        ),
      ),
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
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 6,
        mainAxisSpacing: 8,
        crossAxisCount: 4,
        childAspectRatio: 1.06,
      ),
      itemCount: widget.menu.length,
      itemBuilder: (context, index) {
        return MenuItem(
          url: widget.menu[index]['menuUrl'],
          menuData: widget.menu[index]['remark'],
          menuTitle: widget.menu[index]['menuName'],
          menuSubTitle: widget.menu[index]['remark'],
          menuIcon: widget.menu[index]['menuIcon'],
        );
      },
    );
  }
}

// 首页单个菜单widget
class MenuItem extends StatefulWidget {
  final String menuIcon;
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
  IconNames iconNames;

  IconNames iconNamesFromString(String value) {
    return IconNames.values.firstWhere(
        (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
  }

  _initState() {
    // iconNames = iconNamesFromString(widget.menuIcon);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // IconFont(iconNames, size: 30),
            SizedBox(height: 10),
            Text(
              widget.menuTitle,
              style: TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        String urlString = '/sterilize/barcode';
        if (menu['workingType'] == 'processor') {
          urlString = widget.url;
        }
        if (widget.menuData == 'kojimaking') {
          urlString = '/kojiMaking/List';
        }
        var workShopId = await SharedUtil.instance.getStorage('workShopId');
        Navigator.pushNamed(
          context,
          urlString,
          arguments: {
            'workShopId': workShopId,
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
