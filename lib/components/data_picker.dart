import 'package:flutter/material.dart';
import 'form_item.dart';
import '../utils/picker.dart';

class DataPickerWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool requiredFlg;
  final String valueFormat;
  final Function onChange;
  DataPickerWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.onChange,
      this.valueFormat = 'yyyy-mm-dd HH:nn',
      this.requiredFlg = false})
      : super(key: key);

  @override
  _DataPickerWidgetState createState() => _DataPickerWidgetState();
}

class _DataPickerWidgetState extends State<DataPickerWidget> {
  onTap() {
    var dateType;
    if (widget.valueFormat == 'yyyy-mm-dd') {
      dateType = DateType.YMD;
    } else {
      dateType = DateType.YMD_HM;
    }
    PickerTool.showDatePicker(context,
        dateType: dateType,
        value: widget.prop,
        valueFormat: widget.valueFormat, clickCallback: (val) {
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
