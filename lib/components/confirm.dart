import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/dialog.dart';

$confirm(BuildContext context, {title: '标题', subtitle: '二级标题', success}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ConfirmWidget(
        title: title,
        subtitle: subtitle,
        success: success,
      );
    },
  );
}

class ConfirmWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function success;

  ConfirmWidget({Key key, this.title = '', this.subtitle = '', this.success})
      : super(key: key);

  @override
  _ConfirmWidgetState createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return DiaLogContainer(
      height: 140,
      success: () async {
        Navigator.of(context, rootNavigator: true).pop();
        widget.success();
      },
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
