import 'package:flutter/material.dart';

// 实现双向数据绑定

class FormItem extends StatefulWidget {
  final Widget child;
  final String label;
  final bool requiredFlg;

  FormItem(
      {Key key,
      @required this.child,
      @required this.label,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
          widget.requiredFlg
              ? Text('*', style: TextStyle(color: Colors.red, fontSize: 17))
              : SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
