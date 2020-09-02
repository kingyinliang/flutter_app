import 'package:flutter/material.dart';

// 表头
class PageHead extends StatefulWidget {
  final String title;
  final String subTitle;
  final String orderNo;
  final String potNo;
  PageHead({Key key, this.title, this.subTitle, this.orderNo, this.potNo})
      : super(key: key);

  @override
  _PageHeadState createState() => _PageHeadState();
}

class _PageHeadState extends State<PageHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 92,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/potDetail.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: Color(0xF2F2F2FF),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title ?? '',
                  style: TextStyle(fontSize: 18.0, color: Color(0xFF333333))),
              SizedBox(height: 6),
              Text(widget.subTitle ?? '',
                  style: TextStyle(fontSize: 15.0, color: Color(0xFF333333))),
              SizedBox(height: 6),
              Text('生产订单：${widget.orderNo ?? ''}',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
              SizedBox(height: 6),
              Text('锅单号：${widget.potNo ?? ''}',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
            ],
          )
        ],
      ),
    );
  }
}
