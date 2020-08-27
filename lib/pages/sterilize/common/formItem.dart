import 'package:flutter/material.dart';

// 实现双向数据绑定

class FormItem extends StatefulWidget {
  final String type;
  final String label;
  final String prop;
  final bool requiredFlg;
  final Function onChange;

  FormItem(
      {Key key,
      @required this.type,
      @required this.label,
      @required this.prop,
      this.onChange,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  var inputVal = TextEditingController();
  @override
  void initState() {
    super.initState();
    inputVal.text = widget.prop;
  }

  @override
  void didUpdateWidget(FormItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    inputVal.text = widget.prop;
  }

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
            child: widget.type == 'input'
                ? TextField(
                    controller: inputVal,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Color(0xFF999999)),
                    decoration: InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      widget.onChange(value);
                    },
                  )
                : Text(
                    widget.prop,
                    style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                    textAlign: TextAlign.end,
                  ),
          ),
          widget.type == 'select'
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Color(0xFFCCCCCC),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
