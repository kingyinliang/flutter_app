import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'form_item.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String prop;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;
  final String keyboardType;
  final bool eye;
  final String suffix;
  final bool requiredFlg;
  final Function onChange;

  InputWidget(
      {Key key,
      @required this.label,
      @required this.prop,
      this.enabled = true,
      @required this.onChange,
      this.inputFormatters,
      this.keyboardType,
      this.suffix,
      this.eye = false,
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
        enabled: widget.enabled,
        obscureText: widget.eye,
        keyboardType: widget.keyboardType == 'number'
            ? TextInputType.number
            : widget.keyboardType == 'text'
                ? TextInputType.text
                : TextInputType.visiblePassword,
        inputFormatters: widget.inputFormatters ?? <TextInputFormatter>[],
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: inputVal.text,
            selection: TextSelection.fromPosition(
              TextPosition(
                offset: inputVal.text.length,
              ),
            ),
          ),
        ),
        textAlign: TextAlign.end,
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Color(0xFF999999)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入',
          suffixIcon: widget.suffix != null
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.suffix,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
      label: widget.label,
      requiredFlg: widget.requiredFlg,
    );
  }
}
