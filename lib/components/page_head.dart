import 'package:flutter/material.dart';

// 表头
class PageHead extends StatefulWidget {
  final String title;
  final String subTitle;
  final String threeTitle;
  final String fourTitle;
  PageHead(
      {Key key, this.title, this.subTitle, this.threeTitle, this.fourTitle})
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
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFF52C41A),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  '未录入',
                  style: TextStyle(color: Color(0xFF666666)),
                )
              ],
            ),
          ),
          Row(
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
                      style:
                          TextStyle(fontSize: 18.0, color: Color(0xFF333333))),
                  SizedBox(height: 6),
                  Text(widget.subTitle ?? '',
                      style:
                          TextStyle(fontSize: 15.0, color: Color(0xFF333333))),
                  SizedBox(height: 6),
                  Text(widget.threeTitle ?? '',
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                  SizedBox(height: 6),
                  Text(widget.fourTitle ?? '',
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
