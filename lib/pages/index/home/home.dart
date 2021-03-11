import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/pxunit.dart';
import 'package:dfmdsapp/assets/iconfont/icon_font.dart';
import 'package:dfmdsapp/utils/picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dfmdsapp/utils/version_update.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double _opacity = 0;
  List menuList = [];
  List menu = [];
  List workShopList = [];
  String factoryName = '';
  String workShopName = '';
  String workShopId = '';
  String parentName = '';

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
    Map userData = await SharedUtil.instance.getMapStorage('userData');
    workShopList = userData['userWorkShop'];
    workShopName = workShopList[0]['deptName'];
    workShopId = workShopList[0]['id'];
    parentName = workShopList[0]['parentName'];

    try {
      var res = await Common.getMenuApi();
      menuList = res['data']['menuList'];
      varsionUpdateInit(context);
      setMenu();
    } catch (e) {}
  }

  setMenu() {
    menu = [];
    menuList.forEach((element) {
      if (element['parentName'] == parentName) {
        menu.add(element);
      }
    });
    setState(() {});
  }

  changeWorkShop() {
    PickerTool.showOneRow(
      context,
      label: 'deptName',
      value: 'id',
      selectVal: workShopId,
      data: workShopList,
      clickCallBack: (val) async {
        workShopName = val['deptName'];
        workShopId = val['id'];
        parentName = val['parentName'];
        await SharedUtil.instance
            .saveStringStorage('workShopCode', val['deptCode']);
        if (val['children'].length > 0) {
          await SharedUtil.instance.saveStringStorage(
              'productLineCode', val['children'][0]['deptCode']);
        }
        setMenu();
      },
    );
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
                    changeWorkShop: changeWorkShop,
                  ),
                  SizedBox(height: 10),
                  HomeMenu(
                    menu: menu,
                    workShopId: workShopId,
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
  final changeWorkShop;
  HomeHead({Key key, this.factoryName, this.workShopName, this.changeWorkShop})
      : super(key: key);

  @override
  _HomeHeadState createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {
  List imgList = [
    'lib/assets/images/homeswiper1.png',
    'lib/assets/images/homeswiper2.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: pxUnit(270),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(187.5, 25),
            bottomRight: Radius.elliptical(187.5, 25)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF487BFF),
            Color(0xFFE2EEFE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: pxUnit(45),
            alignment: Alignment.center,
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            height: pxUnit(140),
            child: Swiper(
              autoplay: true,
              loop: true,
              autoplayDisableOnInteraction: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Image.asset(
                    imgList[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                builder: DotSwiperPaginationBuilder(
                  space: 7,
                  size: 6,
                  activeSize: 6,
                  color: Colors.white,
                  activeColor: Color(0xFF487BFF),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              height: pxUnit(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  widget.changeWorkShop();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          '我的权限-${widget.workShopName}',
                          style:
                              TextStyle(color: Color(0xFF487BFF), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xFF487BFF),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 首页菜单widget
class HomeMenu extends StatefulWidget {
  final List menu;
  final String workShopId;
  HomeMenu({Key key, this.menu, this.workShopId}) : super(key: key);

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
          menuItem: widget.menu[index],
          url: widget.menu[index]['menuUrl'],
          workShopId: widget.workShopId,
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
  final String workShopId;
  final Map menuItem;
  MenuItem(
      {Key key,
      this.url,
      this.menuData,
      this.menuIcon,
      this.menuTitle,
      this.workShopId,
      this.menuItem,
      this.menuSubTitle})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  Map menu = {};

  IconNames iconNamesFromString(String value) {
    return IconNames.values.firstWhere(
        (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
  }

  _initState() {}

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
            IconFont(iconNamesFromString(widget.menuIcon), size: 30),
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
        String urlString = '';
        urlString = widget.url;

        if (widget.menuItem['parentName'] == '制曲车间') {
          urlString = '/kojiMaking/List';
          // 异常记录列表（未完成）
        }
        // 杀菌车间扫码
        if (widget.menuItem['parentName'] == '杀菌车间') {
          urlString = '/sterilize/barcode';
          // 工艺控制不走二维码
          if (widget.menuItem['remark'] == 'processor') {
            urlString = widget.url;
          }
        }
        // if (widget.menuData == 'exeption') {
        //   urlString = '/exeptionList';
        // }
        await SharedUtil.instance
            .saveStringStorage('workShopId', widget.workShopId);
        Navigator.pushNamed(
          context,
          urlString,
          arguments: {
            'workShopId': widget.workShopId,
            'url': widget.menuItem['menuUrl'],
            'workingType': widget.menuItem['remark'],
            'title': widget.menuTitle,
          },
        );
      },
    );
  }
}
