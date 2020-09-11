import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import 'package:dfmdsapp/api/api/index.dart';

import '../common/page_head.dart';
import '../common/item_card.dart';
import '../common/remove_btn.dart';

class SemiReceivePage extends StatefulWidget {
  final arguments;
  SemiReceivePage({Key key, this.arguments}) : super(key: key);

  @override
  _SemiReceivePageState createState() => _SemiReceivePageState();
}

class _SemiReceivePageState extends State<SemiReceivePage> {
  List wrapList = [
    {'label': '', 'value': 'fermentPotNo'},
    {'label': '', 'value': 'materialName'},
    {'label': '', 'value': 'consumeBatch'},
    {'label': '发酵罐库存', 'value': 'fermentStorage'},
    {'label': '', 'value': 'tankNo'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
    {'label': '备注：', 'value': 'remark'},
  ];

  List semiList = [];
  getListCard() {
    List listWidget = [];
    listWidget = semiList.asMap().keys.map((index) {
      return SlideButton(
        index: index,
        singleButtonWidth: 70,
        child: ItemCard(
          carTitle: '半成品领用领用数量',
          cardMap: semiList[index],
          title: 'consumeAmount',
          subTitle: 'consumeUnit',
          wrapList: wrapList,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/sterilize/semiReceive/add',
              arguments: {
                'orderNo': widget.arguments['potNum']['orderNo'],
                'stePotNo': widget.arguments['potNum']['pot'],
                'potOrderNo': widget.arguments['potNum']['potNo'],
                'potOrderId': widget.arguments['potNum']['potOrderId'],
                'data': semiList[index],
              },
            ).then((value) => value != null ? _initState() : null);
          },
        ),
        buttons: <Widget>[
          CardRemoveBtn(
            removeOnTab: () => _semiDel(index),
          ),
        ],
      );
    }).toList();
    return listWidget;
  }

  _semiDel(index) async {
    try {
      await Sterilize.semiDelApi({
        'ids': [semiList[index]['id']],
        'potOrderNo': widget.arguments['potNum']['potNo'],
      });
      semiList.removeAt(index);
      setState(() {});
    } catch (e) {}
    setState(() {});
  }

  _initState() async {
    try {
      var res = await Sterilize.semiHomeApi({
        "orderNo": widget.arguments['potNum']['orderNo'],
        "potOrderNo": widget.arguments['potNum']['potNo']
      });
      semiList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '半成品领用'),
      backgroundColor: Color(0xFFF5F5F5),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/sterilize/semiReceive/add',
                    arguments: {
                      'orderNo': widget.arguments['potNum']['orderNo'],
                      'stePotNo': widget.arguments['pot'],
                      'potOrderNo': widget.arguments['potNum']['potNo'],
                      'potOrderId': widget.arguments['potNum']['potOrderId'],
                    },
                  ).then((value) => value != null ? _initState() : null);
                },
                child: Icon(Icons.add),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: MdsWidthButton(
                text: '提交',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          PageHead(
            title:
                '${widget.arguments['potName']} 第${widget.arguments['potNum']['potOrder']}锅',
            subTitle: '${widget.arguments['potNum']['materialName']}',
            orderNo: '${widget.arguments['potNum']['orderNo']}',
            potNo: '${widget.arguments['potNum']['potNo']}',
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
            child: Column(
              children: getListCard(),
            ),
          ),
        ],
      ),
    );
  }
}
