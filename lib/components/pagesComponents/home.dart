import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/page_head.dart';
import 'package:dfmdsapp/components/no_data.dart';
import 'package:dfmdsapp/utils/pxunit.dart' show pxUnit;

class HomePageWidget extends StatefulWidget {
  final String title;
  final String headTitle;
  final String headSubTitle;
  final String headThreeTitle;
  final String headFourTitle;
  final List listData;
  final Function submitFn;
  final Function addFn;
  final Function listWidget;
  HomePageWidget(
      {Key key,
      this.title,
      this.headTitle,
      this.headSubTitle,
      this.headThreeTitle,
      this.headFourTitle,
      @required this.submitFn,
      @required this.addFn,
      @required this.listWidget,
      @required this.listData})
      : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Widget> _getListCard() {
    List<Widget> listWidget = [];
    listWidget = widget.listData.asMap().keys.map((index) {
      return Container(
        child: widget.listWidget(index),
      );
    }).toList();
    if (widget.listData.length == 0) {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
          child: NoDataWidget(),
        )
      ];
    } else {
      return listWidget;
    }
  }

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
              Container(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
                child: Column(
                  children: _getListCard(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 70,
            right: 5,
            child: Container(
              width: 50,
              height: 50,
              child: RawMaterialButton(
                fillColor: Color(0xFF1677FF),
                splashColor: Colors.amber[100],
                child: Icon(
                  Icons.add,
                  size: 26,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
                onPressed: widget.addFn,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            width: pxUnit(375),
            child: MdsWidthButton(
              text: '提交',
              onPressed: widget.submitFn,
            ),
          ),
        ],
      ),
    );
  }
}
