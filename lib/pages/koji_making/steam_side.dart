import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/pagesComponents/home.dart';

class SteamSidePage extends StatefulWidget {
  final arguments;
  SteamSidePage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamSidePageState createState() => _SteamSidePageState();
}

class _SteamSidePageState extends State<SteamSidePage> {
  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      title: widget.arguments['title'],
      headTitle: 'A-1  曲房',
      headSubTitle: '六月香生酱',
      headThreeTitle: '生产订单：83300023456',
      headFourTitle: '入曲日期：2020-07-20',
    );
  }
}
