import 'package:flutter/material.dart';
import 'package:dfmdsapp/utils/pxunit.dart';
import 'package:dfmdsapp/assets/iconfont/icon_font.dart';

$successToast(BuildContext context, {msg: '提交成功'}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ToastWidget(
        type: 'success',
        msg: msg,
      );
    },
  );
}

$errorToast(BuildContext context, {msg: '出现错误'}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ToastWidget(
        type: 'error',
        msg: msg,
      );
    },
  );
}

$warningToast(BuildContext context, {msg: '出现警告'}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return ToastWidget(
        type: 'warning',
        msg: msg,
      );
    },
  );
}

class ToastWidget extends StatefulWidget {
  final String type;
  final String msg;
  ToastWidget({Key key, this.type = 'success', this.msg = ''})
      : super(key: key);

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.of(context, rootNavigator: true).pop();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: pxUnit(300),
            height: pxUnit(150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.type == 'success'
                    ? IconFont(
                        IconNames.iconduihao,
                        size: 64,
                        colors: [
                          '#2CC000',
                          '#2CC000',
                        ],
                      )
                    : widget.type == 'error'
                        ? IconFont(
                            IconNames.iconcuowu,
                            size: 64,
                            colors: ['#F5222D', '#F5222D', '#F5222D'],
                          )
                        : widget.type == 'warning'
                            ? IconFont(
                                IconNames.iconjinggao,
                                size: 64,
                                colors: [
                                  '#F5A623',
                                ],
                              )
                            : SizedBox(),
                SizedBox(height: 20),
                Text(
                  widget.msg,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }
}
