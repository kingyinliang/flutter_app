import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/no_data.dart';
import 'package:dfmdsapp/components/pull_refresh.dart';
import 'package:dfmdsapp/components/search.dart';

const List _tabs = [
  {'label': '待维护', 'type': 'not'},
  {'label': '已保存', 'type': 'save'},
  {'label': '已提交', 'type': 'submit'}
];

class ListPageWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final Function searchFn;
  final List tabs;
  final Function itemBuilder;
  final Map params;
  final paramsOther;
  final Function api;
  final Function itemOnTap;
  ListPageWidget(
      {Key key,
      this.title,
      this.itemOnTap,
      this.hintText,
      this.searchFn,
      this.tabs = _tabs,
      @required this.api,
      @required this.itemBuilder,
      this.params,
      this.paramsOther = 0})
      : super(key: key);

  @override
  _ListPageWidgetState createState() => _ListPageWidgetState();
}

class _ListPageWidgetState extends State<ListPageWidget>
    with SingleTickerProviderStateMixin {
  List tabs = [];
  List<GlobalKey> keyList = [];
  TabController _tabController;
  var index = 0;
  bool tmp = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _initeState();
      _tabController = TabController(vsync: this, length: widget.tabs.length);
      _tabController.addListener(() {
        index = _tabController.index;
      });
    });
  }

  _initeState() {}

  List<Widget> _getTabsViews() {
    if (tmp) {
      tmp = false;
      keyList.clear();
      return widget.tabs.asMap().keys.map((index) {
        GlobalKey childKey = GlobalKey();
        keyList.add(childKey);
        return ListPageTabItemWidget(
          key: keyList[index],
          type: widget.tabs[index]['type'],
          api: widget.api,
          params: widget.params,
          paramsOther: widget.paramsOther,
          itemOnTap: widget.itemOnTap,
          itemBuilder: widget.itemBuilder,
        );
      }).toList();
    } else {
      return widget.tabs.asMap().keys.map((index) {
        return ListPageTabItemWidget(
          key: keyList[index],
          type: widget.tabs[index]['type'],
          api: widget.api,
          params: widget.params,
          paramsOther: widget.paramsOther,
          itemOnTap: widget.itemOnTap,
          itemBuilder: widget.itemBuilder,
        );
      }).toList();
    }
  }

  List _getTabs() {
    return widget.tabs.asMap().keys.map((index) {
      return Tab(text: widget.tabs[index]['label']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        appBar: MdsAppBarWidget(titleData: widget.title),
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              automaticallyImplyLeading: false,
              title: HeadSearchWidget(
                hintText: widget.hintText ?? '订单号',
                searchFn: (String text) {
                  widget.searchFn(text);
                  tmp = true;
                },
              ),
              elevation: 1.5,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(42),
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFF1677FF),
                    labelColor: Color(0xFF1677FF),
                    labelStyle: TextStyle(fontSize: 17),
                    unselectedLabelColor: Color(0xFF333333),
                    unselectedLabelStyle: TextStyle(fontSize: 17),
                    tabs: _getTabs(),
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFF5F5F5),
            body: TabBarView(
              controller: _tabController,
              children: _getTabsViews(),
            ),
          ),
        ),
      ),
    );
  }
}

class ListPageTabItemWidget extends StatefulWidget {
  final String type;
  final Map params;
  final paramsOther;
  final Function api;
  final Function itemOnTap;
  final Function itemBuilder;
  ListPageTabItemWidget(
      {Key key,
      this.type,
      this.itemOnTap,
      this.itemBuilder,
      this.params,
      this.paramsOther,
      this.api})
      : super(key: key);

  @override
  _ListPageTabItemWidgetState createState() => _ListPageTabItemWidgetState();
}

class _ListPageTabItemWidgetState extends State<ListPageTabItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  List data = [];
  int current = 1;

  _initState() async {
    _getData();
  }

  _getData() async {
    try {
      var params = widget.params;
      if (widget.paramsOther == 1) {
        params['size'] = '10';
        params['current'] = '1';
        params['saveType'] = widget.type;
      } else {
        params['size'] = '10';
        params['current'] = '1';
        params['type'] = widget.type;
      }
      var res = await widget.api(params);
      data = res['data']['records'];
      setState(() {});
    } catch (e) {}
  }

  Future<void> _refresh() async {
    current = 1;
    await _getData();
  }

  Future<bool> _pull() async {
    try {
      current++;
      var params = widget.params;
      if (widget.paramsOther == 1) {
        params['size'] = '10';
        params['current'] = '1';
        params['saveType'] = widget.type;
      } else {
        params['size'] = '10';
        params['current'] = current;
        params['type'] = widget.type;
      }
      var res = await widget.api(params);
      data.addAll(res['data']['records']);
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

  Widget _pullR() {
    return PullRefresh(
      data: data,
      pull: _pull,
      refresh: _refresh,
      itemBuilder: (context, index) {
        return InkWell(
          child: widget.itemBuilder(context, index, data),
          onTap: () {
            widget
                .itemOnTap(context, index, data)
                .then((value) => value != null ? _initState() : null);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return data.length != 0 ? _pullR() : NoDataWidget();
  }
}
