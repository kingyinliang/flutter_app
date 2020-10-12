import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/page_head.dart';
import 'package:dfmdsapp/utils/pxunit.dart' show pxUnit;

class HomePageWidget extends StatefulWidget {
  final String title;
  final String headTitle;
  final String headSubTitle;
  final String headThreeTitle;
  final String headFourTitle;
  HomePageWidget(
      {Key key,
      this.title,
      this.headTitle,
      this.headSubTitle,
      this.headThreeTitle,
      this.headFourTitle})
      : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: widget.title, refresh: true),
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: 5),
              PageHead(
                title: '${widget.headTitle}',
                subTitle: '${widget.headSubTitle}',
                threeTitle: '${widget.headThreeTitle}',
                fourTitle: '${widget.headFourTitle}',
              ),
              SizedBox(height: 5),
            ],
          ),
          Positioned(
            bottom: 70,
            right: 5,
            child: RawMaterialButton(
              fillColor: Color(0xFF1677FF),
              splashColor: Colors.amber[100],
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: CircleBorder(),
              onPressed: () {},
            ),
          ),
          Positioned(
            bottom: 10,
            width: pxUnit(375),
            child: MdsWidthButton(
              text: '提交',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
