import 'package:flutter/material.dart';
import 'form_item.dart';
import '../utils/picker.dart';

class SelectWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool requiredFlg;
  final List options;
  final String optionsLabel;
  final String optionsval;

  final Function onChange;

  SelectWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.options,
      @required this.onChange,
      @required this.optionsLabel,
      @required this.optionsval,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  onTap() {
    PickerTool.showOneRow(context,
        selectVal: widget.prop,
        data: widget.options,
        label: widget.optionsLabel,
        value: widget.optionsval, clickCallBack: (val) {
      widget.onChange(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormItem(
      label: widget.label,
      requiredFlg: widget.requiredFlg,
      child: InkWell(
        child: Container(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.prop,
                style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                textAlign: TextAlign.end,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Color(0xFFCCCCCC),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
