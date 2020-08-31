import 'package:flutter/material.dart';
import 'form_item.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool requiredFlg;
  final Function onChange;

  InputWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.onChange,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  var inputVal = TextEditingController();
  @override
  void initState() {
    super.initState();
    inputVal.text = widget.prop;
  }

  @override
  void didUpdateWidget(InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    inputVal.text = widget.prop;
  }

  @override
  Widget build(BuildContext context) {
    return FormItem(
      child: TextField(
        controller: inputVal,
        textAlign: TextAlign.end,
        style: TextStyle(color: Color(0xFF999999)),
        decoration: InputDecoration(border: InputBorder.none),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
      label: widget.label,
      requiredFlg: widget.requiredFlg,
    );
  }
}
