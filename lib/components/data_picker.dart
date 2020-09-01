import 'package:flutter/material.dart';
import 'form_item.dart';
import '../utils/picker.dart';

class DataPickerWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool requiredFlg;
  final Function onChange;
  DataPickerWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.onChange,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _DataPickerWidgetState createState() => _DataPickerWidgetState();
}

class _DataPickerWidgetState extends State<DataPickerWidget> {
  onTap() {
    PickerTool.showDatePicker(context,
        dateType: DateType.YMD_HM,
        value: widget.prop,
        valueFormat: 'yyyy-mm-dd hh:nn', clickCallback: (val) {
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
