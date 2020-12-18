import 'package:flutter/material.dart';

//刷新状态枚举
enum LoadingStatus {
  //正在加载中
  STATUS_LOADING,
  //数据加载完毕
  STATUS_COMPLETED,
  //空闲状态
  STATUS_IDEL
}

class PullRefresh extends StatefulWidget {
  final List data;
  final Function pull;
  final Function refresh;
  final Function itemBuilder;
  PullRefresh(
      {Key key,
      @required this.data,
      @required this.itemBuilder,
      this.pull,
      this.refresh})
      : super(key: key);

  @override
  _PullRefreshState createState() => _PullRefreshState();
}

class _PullRefreshState extends State<PullRefresh> {
  String loadText = '加载中...';
  var loadStatus = LoadingStatus.STATUS_IDEL;
  ScrollController _scrollController = new ScrollController();

  Future<void> _onRefresh() async {
    await widget.refresh();
    setState(() {
      loadText = '加载中...';
      loadStatus = LoadingStatus.STATUS_IDEL;
    });
  }

  _loadingView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: loadStatus == LoadingStatus.STATUS_LOADING ? true : false,
            child: SizedBox(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue)),
              width: 20.0,
              height: 20.0,
            ),
          ),
          SizedBox(width: 20),
          Text(
            loadText,
            style: TextStyle(color: Colors.blue, fontSize: 16),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      //判断 当滑动到最底部的时候，去加载更多的数据
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //此时加载下一页数据
        _getMoreData();
      }
    });
    super.initState();
  }

  Future _getMoreData() async {
    if (loadStatus == LoadingStatus.STATUS_IDEL) {
      setState(() {
        loadStatus = LoadingStatus.STATUS_LOADING;
      });
      var res = await widget.pull();
      setState(() {
        if (res) {
          loadStatus = LoadingStatus.STATUS_IDEL;
          loadText = '加载中...';
        } else {
          loadText = '加载完毕';
          loadStatus = LoadingStatus.STATUS_COMPLETED;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: widget.data.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.data.length) {
            if (widget.data.length > 9) {
              return _loadingView();
            } else {
              loadText = '加载完毕';
              loadStatus = LoadingStatus.STATUS_COMPLETED;
              return _loadingView();
            }
          } else {
            return widget.itemBuilder(context, index);
          }
        },
        controller: _scrollController,
      ),
      onRefresh: _onRefresh,
    );
  }
}
