import 'package:flutter/material.dart';
import './form_item.dart';

class SwitchWidget extends StatefulWidget {
  final String label;
  final bool prop;
  final bool requiredFlg;
  final Function onChange;
  SwitchWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.onChange,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return FormItem(
      label: widget.label,
      requiredFlg: widget.requiredFlg,
      child: Container(
        alignment: Alignment.centerRight,
        child: Switch(
          activeColor: Color(0xFF487BFF),
          value: widget.prop,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
