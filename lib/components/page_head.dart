import 'package:flutter/material.dart';

// 表头
class PageHead extends StatefulWidget {
  final String title;
  final String subTitle;
  final String threeTitle;
  final String fourTitle;
  final String status;
  final String statusName;
  PageHead({
    Key key,
    this.title,
    this.status,
    this.statusName,
    this.subTitle,
    this.threeTitle,
    this.fourTitle,
  }) : super(key: key);

  @override
  _PageHeadState createState() => _PageHeadState();
}

class _PageHeadState extends State<PageHead> {
  Color statusColor;

  @override
  void initState() {
    super.initState();
  }

  getColor() {
    switch (widget.statusName) {
      case '未录入':
        statusColor = Color(0xFF52C41A);
        break;
      case '已保存':
        statusColor = Color(0xFF52C41A);
        break;
      case '已退回':
        statusColor = Color(0xFFF94630);
        break;
      case '待审核':
        statusColor = Color(0xFF487BFF);
        setState(() {});
        break;
      case '已审核':
        statusColor = Color(0xFF52C41A);
        break;
      default:
        statusColor = Color(0xFF52C41A);
    }
    return statusColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          widget.status == '' || widget.status == 'null'
              ? SizedBox()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: getColor(),
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${widget.statusName}',
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
                  widget.title == ''
                      ? SizedBox()
                      : Text(widget.title ?? '',
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xFF333333))),
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
