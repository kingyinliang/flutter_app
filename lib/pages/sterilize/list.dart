import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/pull_refresh.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/components/no_data.dart';
import 'package:dfmdsapp/components/search.dart';

class AcceAddListPage extends StatefulWidget {
  final arguments;
  AcceAddListPage({Key key, this.arguments}) : super(key: key);

  @override
  _AcceAddListPageState createState() => _AcceAddListPageState();
}

class _AcceAddListPageState extends State<AcceAddListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: widget.arguments['title']),
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              automaticallyImplyLeading: false,
              title: HeadSearchWidget(),
              elevation: 1.5,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(42),
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFF1677FF),
                    labelColor: Color(0xFF1677FF),
                    labelStyle: TextStyle(fontSize: 17),
                    unselectedLabelColor: Color(0xFF333333),
                    unselectedLabelStyle: TextStyle(fontSize: 17),
                    tabs: <Widget>[
                      Tab(text: '待维护'),
                      Tab(text: '已保存'),
                      Tab(text: '已提交'),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFF5F5F5),
            body: TabBarView(
              children: <Widget>[
                ListItemWidget(
                  type: 'not',
                  url: widget.arguments['url'],
                  pot: widget.arguments['pot'],
                  potName: widget.arguments['potName'],
                  workingType: widget.arguments['workingType'],
                ),
                ListItemWidget(
                  type: 'save',
                  url: widget.arguments['url'],
                  pot: widget.arguments['pot'],
                  potName: widget.arguments['potName'],
                  workingType: widget.arguments['workingType'],
                ),
                ListItemWidget(
                  type: 'submit',
                  url: widget.arguments['url'],
                  pot: widget.arguments['pot'],
                  potName: widget.arguments['potName'],
                  workingType: widget.arguments['workingType'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final String type;
  final String pot;
  final String potName;
  final String url;
  final String workingType;
  ListItemWidget(
      {Key key,
      @required this.url,
      @required this.pot,
      @required this.potName,
      @required this.type,
      @required this.workingType})
      : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget>
    with AutomaticKeepAliveClientMixin {
  List listviewList = [];
  int current = 1;

  _initState() async {
    getData();
  }

  Future<void> getData() async {
    try {
      var workShopId = await SharedUtil.instance.getStorage('workShopId');
      var res = await Sterilize.sterilizeListApi({
        'workShop': workShopId,
        'type': widget.type,
        'workingType': widget.workingType,
        'potNo': widget.pot,
        'current': '1',
        'size': '10',
      });
      listviewList = res['data']['records'];
      setState(() {});
    } catch (e) {}
  }

  Future<bool> _pull() async {
    try {
      current++;
      var workShopId = await SharedUtil.instance.getStorage('workShopId');
      var res = await Sterilize.sterilizeListApi({
        'workShop': workShopId,
        'type': widget.type,
        'workingType': widget.workingType,
        'potNo': widget.pot,
        'current': current,
        'size': '10',
      });
      listviewList.addAll(res['data']['records']);
      setState(() {});
      if (current * 10 >= res['data']['total']) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future<void> _refresh() async {
    current = 1;
    await getData();
  }

  Widget pullR() {
    return PullRefresh(
      data: listviewList,
      pull: _pull,
      refresh: _refresh,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset("lib/assets/images/pot.jpg"),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('第${listviewList[index]['potOrder']}锅',
                        style: TextStyle(fontSize: 17.0)),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text(
                    '${listviewList[index]['materialCode']} ${listviewList[index]['materialName']}'),
                Text(
                    '${listviewList[index]['orderNo']}-${listviewList[index]['statusName']}'),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, widget.url, arguments: {
                'status': listviewList[index]['status'],
                'statusName': listviewList[index]['statusName'],
                'pot': widget.pot,
                'potName': widget.potName,
                'potNum': listviewList[index],
              }).then((value) => value != null ? _initState() : null);
            },
          ),
        );
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
    return listviewList.length != 0 ? pullR() : NoDataWidget();
  }
}
