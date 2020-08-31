import 'package:flutter/material.dart';
import './form_item.dart';

class FormTextWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool requiredFlg;
  FormTextWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _FormTextWidgetState createState() => _FormTextWidgetState();
}

class _FormTextWidgetState extends State<FormTextWidget> {
  @override
  Widget build(BuildContext context) {
    return FormItem(
      label: widget.label,
      requiredFlg: widget.requiredFlg,
      child: Text(
        widget.prop,
        style: TextStyle(color: Color(0xFF999999), fontSize: 15),
        textAlign: TextAlign.end,
      ),
    );
  }
}
