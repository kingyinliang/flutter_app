import 'package:flutter/material.dart';

class SliverTabBarWidget extends StatefulWidget {
  final Function tabChange;
  final List<Widget> children;
  final List<Widget> tabBarChildren;
  final List<Widget> tabBarViewChildren;
  SliverTabBarWidget(
      {Key key,
      this.tabChange,
      this.children,
      this.tabBarChildren,
      this.tabBarViewChildren})
      : super(key: key);

  @override
  _SliverTabBarWidgetState createState() => _SliverTabBarWidgetState();
}

class _SliverTabBarWidgetState extends State<SliverTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: widget.tabBarChildren.length);
    _tabController.addListener(() {
      widget.tabChange(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: widget.children,
            ),
          ),
          //中间悬浮subtitle
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            // ignore: deprecated_member_use
            child: SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              pinned: true,
              title: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xFF1677FF),
                labelColor: Color(0xFF1677FF),
                labelStyle: TextStyle(fontSize: 17),
                unselectedLabelColor: Color(0xFF333333),
                unselectedLabelStyle: TextStyle(fontSize: 17),
                tabs: widget.tabBarChildren,
              ),
            ),
          )
        ];
      },
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: widget.tabBarViewChildren,
        ),
      ),
    );
  }
}
